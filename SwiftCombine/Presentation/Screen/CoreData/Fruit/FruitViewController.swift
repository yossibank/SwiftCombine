import Combine
import UIKit

// MARK: - inject

extension FruitViewController: VCInjectable {
    typealias VM = FruitViewModel
    typealias UI = FruitUI
}

// MARK: - stored properties

final class FruitViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension FruitViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchAll()
        ui.setupView(rootView: view)
        ui.setupTableView(delegate: self)
        setupEvent()
        bindToViewModel()
        bindToView()
    }
}

// MARK: - private methods

private extension FruitViewController {
    func setupEvent() {
        ui.saveButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }

            self.ui.clearText()
            self.viewModel.add()
            self.viewModel.fetchAll()
        }
        .store(in: &cancellables)
    }

    func bindToViewModel() {
        ui.nameTextFieldPublisher
            .assign(to: \.name, on: viewModel)
            .store(in: &cancellables)
    }

    func bindToView() {
        viewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.ui.updateDataSource(items: items)
            }
            .store(in: &cancellables)

        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { state in
                switch state {
                case .standby:
                    Logger.debug(message: "standby")

                case .loading:
                    Logger.debug(message: "loading")

                case let .done(response):
                    Logger.debug(message: "\(response.map(\.name))")

                case let .failed(error):
                    Logger.debug(message: error.localizedDescription)
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - delegate

extension FruitViewController: UITableViewDelegate {}
