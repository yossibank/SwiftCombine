import UIKit

// MARK: - stored properties

final class DEBUG_FlowController: UIViewController {
    private var serverType: UserDefaultEnumKey.ServerType?

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
        children.first?.view.frame = view.bounds
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

    func popOver(sourceView: UIView, sourceRect: CGRect) {
        start()
        modalPresentationStyle = .popover
        preferredContentSize = .init(
            width: sourceView.frame.width,
            height: sourceView.frame.height / 2
        )
        popoverPresentationController?.sourceView = sourceView
        popoverPresentationController?.sourceRect = sourceRect
        popoverPresentationController?.permittedArrowDirections = .down
        popoverPresentationController?.delegate = self
        serverType = AppDataHolder.serverType
    }
}

// MARK: - delegate

extension DEBUG_FlowController: DEBUG_ViewControllerDelegate {
    func didControllerSelected(item: DEBUG_Controller) {
        switch item {
        case .joke:
            let vc = AppControllers.joke()
            navVC.pushViewController(vc, animated: true)
        }
    }

    func didCoreDataSelected(item: DEBUG_CoreData) {
        switch item {
        case .fruit:
            let vc = AppControllers.coreData()
            navVC.pushViewController(vc, animated: true)
        }
    }

    func didCombineSelected(item: DEBUG_Combine) {
        switch item {
        case .just:
            let vc = AppControllers.Combine.just()
            navVC.pushViewController(vc, animated: true)

        case .subject:
            let vc = AppControllers.Combine.subject()
            navVC.pushViewController(vc, animated: true)

        case .future:
            let vc = AppControllers.Combine.future()
            navVC.pushViewController(vc, animated: true)

        case .deferred:
            let vc = AppControllers.Combine.deferred()
            navVC.pushViewController(vc, animated: true)
        }
    }
}

extension DEBUG_FlowController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle {
        .none
    }

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        guard AppDataHolder.serverType != serverType else {
            return
        }

        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        let appFlowController = AppFlowController()
        window?.rootViewController = appFlowController
        window?.makeKeyAndVisible()
        appFlowController.start()
    }
}
