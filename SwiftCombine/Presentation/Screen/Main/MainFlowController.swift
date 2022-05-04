import UIKit

// MARK: - properties & init

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

// MARK: - internal methods

extension MainFlowController {
    func configureTab(_ type: UserDefaultEnumKey.ServerType) {
        tabController.configureTab(type)
    }
}

extension MainFlowController: FlowController {
    func start() {
        let flows: [FlowController]
        flows = [HomeFlowController(), DEBUG_FlowController()]

        tabController.setViewControllers(flows, animated: false)

        flows.forEach { $0.start() }

        configureTab(AppDataHolder.serverType)
    }
}
