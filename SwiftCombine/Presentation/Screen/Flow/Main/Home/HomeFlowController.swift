import UIKit

// MARK: - stored properties & init

final class HomeFlowController: UIViewController {
    private let navVC = NavigationController()

    init() {
        super.init(nibName: nil, bundle: nil)
        add(navVC)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - override methods

extension HomeFlowController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        children.first?.view.frame = tabBarController?.view.bounds ?? .zero
    }
}

// MARK: - protocol

extension HomeFlowController: FlowController {
    func start() {
        let vc = AppControllers.home()
        tabBarItem.title = "Home"
        tabBarItem.image = UIImage(systemName: "house")

        navVC.viewControllers = [vc]
    }
}
