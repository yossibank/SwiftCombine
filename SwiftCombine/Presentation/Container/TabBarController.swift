import UIKit

enum TabBarItem: Int, CaseIterable {
    case home
    case debug

    var title: String {
        switch self {
        case .home:
            return "ホーム"

        case .debug:
            return "デバッグ"
        }
    }

    var image: UIImage? {
        switch self {
        case .home:
            return .init(systemName: "house")

        case .debug:
            return .init(systemName: "gamecontroller")
        }
    }

    var tabBarItem: UITabBarItem {
        return .init(title: title, image: image, tag: rawValue)
    }

    var viewController: UIViewController {
        switch self {
        case .home:
            let homeVC = NavigationController(rootViewController: AppControllers.Home())
            homeVC.tabBarItem = tabBarItem
            return homeVC

        case .debug:
            let debugVC = NavigationController(rootViewController: AppControllers.Debug())
            debugVC.tabBarItem = tabBarItem
            return debugVC
        }
    }
}

// MARK: - override methods

final class TabBarController: UITabBarController {
    private var serverType: UserDefaultEnumKey.ServerType?

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers(TabBarItem.allCases.map(\.viewController), animated: false)
        setupEvent()
        configureTab(AppDataHolder.serverType)
    }
}

// MARK: - internal methods

extension TabBarController {
    func configureTab(_ type: UserDefaultEnumKey.ServerType) {
        let debugTab = viewControllers?[TabBarItem.debug.rawValue]
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.shadowColor = .lightGray.withAlphaComponent(0.5)

        switch type {
        case .production:
            debugTab?.tabBarItem.title = "DEBUG(本番)"
            appearance.backgroundColor = .systemBackground

        case .stage:
            debugTab?.tabBarItem.title = "DEBUG(ステージ)"
            appearance.backgroundColor = .blue.withAlphaComponent(0.8)

        case .prestage:
            debugTab?.tabBarItem.title = "DEBUG(プレステージ)"
            appearance.backgroundColor = .red.withAlphaComponent(0.8)
        }

        tabBar.standardAppearance = appearance

        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}

// MARK: - private methods

private extension TabBarController {
    func setupEvent() {
        let longPressGesture: UILongPressGestureRecognizer = .init(
            target: self,
            action: #selector(longPressTabbar)
        )
        tabBar.addGestureRecognizer(longPressGesture)
    }

    @objc func longPressTabbar(_ sender: UILongPressGestureRecognizer) {
        #if DEBUG
        if sender.state == .ended {
            let vc = AppControllers.Debug()
            vc.modalPresentationStyle = .popover
            vc.preferredContentSize = .init(
                width: view.frame.width,
                height: view.frame.height / 2
            )
            vc.popoverPresentationController?.sourceView = view
            vc.popoverPresentationController?.sourceRect = tabBar.frame
            vc.popoverPresentationController?.permittedArrowDirections = .down
            vc.popoverPresentationController?.delegate = self
            serverType = AppDataHolder.serverType
            present(vc, animated: true)
        }
        #endif
    }
}

extension TabBarController: UIPopoverPresentationControllerDelegate {
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
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }
}
