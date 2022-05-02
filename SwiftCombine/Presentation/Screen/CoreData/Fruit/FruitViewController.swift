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
        ui.bindUI()
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
        ui.addButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }

            self.ui.clear()
            self.viewModel.add()
            self.viewModel.fetchAll()
        }
        .store(in: &cancellables)

        ui.deleteButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }

            self.ui.clear()
            self.viewModel.delete()
            self.viewModel.fetchAll()
        }
        .store(in: &cancellables)
    }

    func bindToViewModel() {
        ui.addTextFieldPublisher
            .assign(to: \.addName, on: viewModel)
            .store(in: &cancellables)

        ui.deleteTextFieldPublisher
            .assign(to: \.deleteName, on: viewModel)
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
