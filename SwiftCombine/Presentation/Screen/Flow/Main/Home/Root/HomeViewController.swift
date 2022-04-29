import Combine
import UIKit

// MARK: - inject

extension HomeViewController: VCInjectable {
    typealias VM = HomeViewModel
    typealias UI = NoUserInterface
}

// MARK: - stored properties & init

final class HomeViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!

    private let switcher: UISwitch = {
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UISwitch())

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(switcher)

        NSLayoutConstraint.activate([
            switcher.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            switcher.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - private methods

private extension HomeViewController {
}
