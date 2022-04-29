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

    func didCoreDataSelected(item: DEBUG_CoreData) {
        switch item {
        case .sample:
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
}
