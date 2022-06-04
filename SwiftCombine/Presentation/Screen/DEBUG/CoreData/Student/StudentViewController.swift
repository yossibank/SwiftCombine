import Combine
import UIKit

// MARK: - inejct

extension StudentViewController: VCInjectable {
    typealias VM = StudentViewModel
    typealias UI = StudentUI
    typealias R = StudentRouting
}

// MARK: - properties & init

final class StudentViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
    var routing: R! { didSet { routing.viewController = self } }

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension StudentViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()
        ui.setupView(rootView: view)
        ui.setupNavigationBar(
            navigationBar: navigationController?.navigationBar,
            navigationItem: navigationItem
        )
        ui.setupTableView(delegate: self)
        setupEvent()
        bindToView()
    }
}

// MARK: - private methods

private extension StudentViewController {
    func setupEvent() {
        ui.navButtonTapPublisher.sink { [weak self] _ in
            self?.routing.showClubScreen()
        }
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

extension StudentViewController: UITableViewDelegate {}
