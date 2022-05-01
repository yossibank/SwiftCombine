import Combine
import UIKit

// MARK: - inject

extension JokeViewController: VCInjectable {
    typealias VM = JokeViewModel
    typealias UI = JokeUI
}

// MARK: - stored properties & init

final class JokeViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension JokeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setupView(rootView: view)
        viewModel.fetch()
        bindToView()
    }
}

// MARK: - private methods

private extension JokeViewController {
    func bindToView() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }

                switch state {
                case .standby:
                    Logger.debug(message: "standby")

                case .loading:
                    Logger.debug(message: "loading")

                case let .done(response):
                    Logger.debug(message: "\(response)")

                    self.ui.text = """
                    ID: \(response.id)

                    Joke: \(response.joke)

                    Status: \(response.status)
                    """

                case let .failed(error):
                    Logger.debug(message: error.localizedDescription)
                }
            }
            .store(in: &cancellables)
    }
}