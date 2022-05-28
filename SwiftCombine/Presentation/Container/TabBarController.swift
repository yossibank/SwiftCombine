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
    enum TabType: Int {
        case home
        case debug
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers(TabBarItem.allCases.map(\.viewController), animated: false)
        setupView()
        setupEvent()
    }
}

// MARK: - internal methods

extension TabBarController {
    func configureTab(_ type: UserDefaultEnumKey.ServerType) {
        let debugTab = viewControllers?[TabType.debug.rawValue]
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()

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
    func setupView() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .lightGray.withAlphaComponent(0.5)
        tabBar.standardAppearance = appearance

        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }

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
            let flow = DEBUG_FlowController()
            flow.popOver(sourceView: view, sourceRect: tabBar.frame)
            present(flow, animated: true)
        }
        #endif
    }
}
