import Combine
import UIKit

protocol JokeSearchViewControllerDelegate: AnyObject {
    func showJokeGetScreen(jokeId: String)
}

// MARK: - inject

extension JokeSearchViewController: VCInjectable {
    typealias VM = JokeSearchViewModel
    typealias UI = JokeSearchUI
    typealias R = NoRouting
}

// MARK: - properties & init

final class JokeSearchViewController: IndicatorViewController {
    var viewModel: VM!
    var ui: UI!
    var routing: R!

    weak var delegate: JokeSearchViewControllerDelegate!

    private var isAddLoading: Bool = false
    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension JokeSearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch(isAdditional: false)
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
            .sink { [weak self] state in
                switch state {
                case .standby:
                    Logger.debug(message: "standby")

                case .loading:
                    self?.startIndicator()
                    Logger.debug(message: "loading")

                case let .done(entity):
                    self?.stopIndicator()
                    self?.isAddLoading = false
                    Logger.debug(message: "\(entity)")

                case let .failed(error):
                    self?.stopIndicator()
                    self?.isAddLoading = false
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
        delegate.showJokeGetScreen(jokeId: jokeId)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ui.isShouldLoading && !isAddLoading {
            isAddLoading = true
            viewModel.fetch(isAdditional: true)
        }
    }
}
