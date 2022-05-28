import Combine
import UIKit

// MARK: - inject

extension JokeRandomViewController: VCInjectable {
    typealias VM = JokeRandomViewModel
    typealias UI = JokeRandomUI
    typealias R = NoRouting
}

// MARK: - properties & init

final class JokeRandomViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
    var routing: R!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension JokeRandomViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()
        ui.setupView(rootView: view)
        bindToView()
    }
}

// MARK: - private methods

private extension JokeRandomViewController {
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

                case let .done(entity):
                    Logger.debug(message: "\(entity)")

                    self.ui.text = """
                    ID: \(entity.id)

                    Joke: \(entity.joke)

                    Status: \(entity.status)
                    """

                case let .failed(error):
                    Logger.debug(message: error.localizedDescription)
                }
            }
            .store(in: &cancellables)
    }
}
