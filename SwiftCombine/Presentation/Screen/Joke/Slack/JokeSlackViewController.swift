import Combine
import UIKit

// MARK: - inject

extension JokeSlackViewController: VCInjectable {
    typealias VM = JokeSlackViewModel
    typealias UI = JokeSlackUI
}

// MARK: - stored properties & init

final class JokeSlackViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension JokeSlackViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setupView(rootView: view)
        viewModel.fetch()
        bindToView()
    }
}

// MARK: - private methods

private extension JokeSlackViewController {
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
                    Attachments:Fallback: \(response.attachments.map(\.fallback))

                    Attachments:Foooter: \(response.attachments.map(\.footer))

                    Attachments:Text: \(response.attachments.map(\.text))

                    ResponseType: \(response.responseType)

                    Username: \(response.username)
                    """

                case let .failed(error):
                    Logger.debug(message: error.localizedDescription)
                }
            }
            .store(in: &cancellables)
    }
}
