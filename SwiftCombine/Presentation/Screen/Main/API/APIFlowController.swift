import UIKit

// MARK: - stored properties & init

final class APIFlowController: UIViewController {
    private let navVC = UINavigationController()

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
        let vc = APIViewController()
        tabBarItem.title = "home"

        navVC.viewControllers = [vc]
    }
}
