import UIKit

// MARK: - stored properties & init

final class CombineFlowController: UIViewController {
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

extension CombineFlowController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        children.first?.view.frame = tabBarController?.view.bounds ?? .zero
    }
}

// MARK: - protocol

extension CombineFlowController: FlowController {
    func start() {
        let vc = AppControllers.combine()
        tabBarItem.title = "Combine"
        tabBarItem.image = UIImage(systemName: "swift")

        navVC.viewControllers = [vc]
    }
}
