import Combine
import UIKit

// MARK: - inject

extension FruitViewController: VCInjectable {
    typealias VM = FruitViewModel
    typealias UI = FruitUI
    typealias R = NoRouting
}

// MARK: - properties & init

final class FruitViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
    var routing: R!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension FruitViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()
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
            self.viewModel.fetch()
        }
        .store(in: &cancellables)

        ui.deleteButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }

            self.ui.clear()
            self.viewModel.delete()
            self.viewModel.fetch()
        }
        .store(in: &cancellables)
    }

    func bindToViewModel() {
        ui.addTextFieldPublisher
            .removeDuplicates()
            .assign(to: \.addName, on: viewModel)
            .store(in: &cancellables)

        ui.deleteTextFieldPublisher
            .removeDuplicates()
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

                case let .done(entity):
                    Logger.debug(message: "\(entity.map(\.name))")

                case let .failed(error):
                    Logger.debug(message: error.localizedDescription)
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - delegate

extension FruitViewController: UITableViewDelegate {}
