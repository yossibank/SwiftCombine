import UIKit

// MARK: - stored properties & init

final class APIFlowController: UIViewController {
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

extension APIFlowController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        children.first?.view.frame = tabBarController?.view.bounds ?? .zero
    }
}

// MARK: - protocol

extension APIFlowController: FlowController {
    func start() {
        let vc = AppControllers.api()
        tabBarItem.title = "API"
        tabBarItem.image = UIImage(systemName: "network")

        navVC.viewControllers = [vc]
    }
}
