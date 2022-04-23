import Combine
import UIKit

// MARK: - inject

extension JustViewController: VCInjectable {
    typealias VM = JustViewModel
    typealias UI = NoUserInterface
}

// MARK: - stored properties & init

final class JustViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension JustViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        observation()
    }
}

// MARK: - private methods

private extension JustViewController {
    func observation() {
        viewModel.executeNoJust()
        viewModel.executeJust()
    }
}
