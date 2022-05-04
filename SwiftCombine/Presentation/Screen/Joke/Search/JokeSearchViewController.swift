import Combine
import UIKit

// MARK: - inject

extension JokeSearchViewController: VCInjectable {
    typealias VM = JokeSearchViewModel
    typealias UI = JokeSearchUI
}

// MARK: - stored properties

final class JokeSearchViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension JokeSearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()
        ui.setupView(rootView: view)
        ui.setupTableView(delegate: self)
        bindToView()
    }
}

// MARK: - private methods

private extension JokeSearchViewController {
    func bindToView() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .standby:
                    Logger.debug(message: "standby")

                case .loading:
                    Logger.debug(message: "loading")

                case let .done(entity):
                    self?.ui.updateDataSource(
                        items: entity.results.map { .init(id: $0.id, joke: $0.joke) }
                    )
                    Logger.debug(message: "\(entity.results.map(\.id))")

                case let .failed(error):
                    Logger.debug(message: error.localizedDescription)
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - delegate

extension JokeSearchViewController: UITableViewDelegate {}
