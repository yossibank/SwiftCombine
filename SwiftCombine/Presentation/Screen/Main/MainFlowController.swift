import UIKit

// MARK: - stored properties & init

final class MainFlowController: UIViewController {
    private let tabController = TabBarController()

    init() {
        super.init(nibName: nil, bundle: nil)
        add(tabController)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - override methods

extension MainFlowController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        children.first?.view.frame = view.bounds
    }
}

extension MainFlowController: FlowController {
    func start() {
        let flows: [FlowController]
        flows = [HomeFlowController(), APIFlowController(), CombineFlowController()]

        tabController.setViewControllers(flows, animated: false)

        flows.forEach { $0.start() }
    }
}
