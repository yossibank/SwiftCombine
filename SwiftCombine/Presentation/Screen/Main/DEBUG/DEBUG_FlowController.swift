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
        vc.delegate = self

        tabBarItem.title = "DEBUG"
        tabBarItem.image = UIImage(systemName: "gamecontroller")

        navVC.viewControllers = [vc]
    }
}

// MARK: - delegate

extension DEBUG_FlowController: DEBUG_ViewControllerDelegate {
    func didControllerSelected(item: DEBUG_Controller) {
        switch item {
        case .api:
            let vc = AppControllers.api()
            navVC.pushViewController(vc, animated: true)
        }
    }

    func didCombineSelected(item: DEBUG_Combine) {
        switch item {
        case .future:
            let vc = AppControllers.combine()
            navVC.pushViewController(vc, animated: true)
        }
    }
}
