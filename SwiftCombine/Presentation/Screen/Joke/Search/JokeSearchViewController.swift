import Combine
import UIKit

protocol JokeSearchViewControllerDelegate: AnyObject {
    func didJokeSelected(jokeId: String)
}

// MARK: - inject

extension JokeSearchViewController: VCInjectable {
    typealias VM = JokeSearchViewModel
    typealias UI = JokeSearchUI
}

// MARK: - stored properties

final class JokeSearchViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!

    weak var delegate: JokeSearchViewControllerDelegate!

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
                    Logger.debug(message: "\(entity)")

                case let .failed(error):
                    Logger.debug(message: error.localizedDescription)
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - delegate

extension JokeSearchViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: false)

        let jokeId = viewModel.items[indexPath.row].id
        delegate.didJokeSelected(jokeId: jokeId)
    }
}
