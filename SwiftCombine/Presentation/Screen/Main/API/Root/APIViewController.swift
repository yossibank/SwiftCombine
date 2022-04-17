import UIKit

// MARK: - inject

extension APIViewController: VCInjectable {
    typealias VM = NoViewModel
    typealias UI = NoUserInterface
}

// MARK: - stored properties & init

final class APIViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
}

// MARK: - override methods

extension APIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
