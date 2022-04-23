import Combine
import UIKit

// MARK: - inject

extension HomeViewController: VCInjectable {
    typealias VM = NoViewModel
    typealias UI = NoUserInterface
}

// MARK: - stored properties & init

final class HomeViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
}

// MARK: - override methods

extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}
