import UIKit

// MARK: - stored properties

final class DEBUG_FlowController: UIViewController {
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

extension DEBUG_FlowController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        children.first?.view.frame = tabBarController?.view.bounds ?? .zero
    }
}

// MARK: - protocol

extension DEBUG_FlowController: FlowController {
    func start() {
        let vc = AppControllers.debug()

        tabBarItem.title = "DEBUG"
        tabBarItem.image = UIImage(systemName: "gamecontroller")

        navVC.viewControllers = [vc]
    }
}
