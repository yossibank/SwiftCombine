import Combine
import UIKit

// MARK: - inject

extension JokeSlackViewController: VCInjectable {
    typealias VM = JokeSlackViewModel
    typealias UI = JokeSlackUI
    typealias R = NoRouting
}

// MARK: - properties & init

final class JokeSlackViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
    var routing: R!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension JokeSlackViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()
        ui.setupView(rootView: view)
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

                case let .done(entity):
                    Logger.debug(message: "\(entity)")

                    self.ui.text = """
                    Attachments:Fallback: \(entity.attachments.map(\.fallback))

                    Attachments:Foooter: \(entity.attachments.map(\.footer))

                    Attachments:Text: \(entity.attachments.map(\.text))

                    ResponseType: \(entity.responseType)

                    Username: \(entity.username)
                    """

                case let .failed(error):
                    Logger.debug(message: error.localizedDescription)
                }
            }
            .store(in: &cancellables)
    }
}
