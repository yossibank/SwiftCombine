import UIKit

// MARK: - override methods

final class TabBarController: UITabBarController {
    enum TabType: Int {
        case home
        case debug
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .lightGray.withAlphaComponent(0.5)
        tabBar.standardAppearance = appearance

        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }

        let longPressGesture: UILongPressGestureRecognizer = .init(
            target: self,
            action: #selector(longPressTabbar)
        )
        tabBar.addGestureRecognizer(longPressGesture)
    }

    @objc private func longPressTabbar(_ sender: UILongPressGestureRecognizer) {
        #if DEBUG
        if sender.state == .ended {
            let flow = DEBUG_FlowController()
            flow.popOver(sourceView: view, sourceRect: tabBar.frame)
            present(flow, animated: true)
        }
        #endif
    }

    func updateTab(_ type: UserDefaultEnumKey.ServerType) {
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
