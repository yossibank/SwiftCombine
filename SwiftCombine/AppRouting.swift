import UIKit

final class AppRouting: Routing {
    weak var viewController: UIViewController?
}

extension AppRouting {
    func start(window: UIWindow?) {
        let tabController = TabBarController()

        let homeVC = AppControllers.Home()
        homeVC.tabBarItem.title = "Home"
        homeVC.tabBarItem.image = UIImage(systemName: "house")

        let debugVC = AppControllers.Debug()
        debugVC.tabBarItem.title = "Debug"
        debugVC.tabBarItem.image = UIImage(systemName: "gamecontroller")

        tabController.setViewControllers([homeVC, debugVC], animated: false)

        window?.rootViewController = tabController
        window?.makeKeyAndVisible()
    }
}
