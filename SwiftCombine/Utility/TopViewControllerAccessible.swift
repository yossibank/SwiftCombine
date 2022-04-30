import UIKit

protocol TopViewControllerAccessible {}

extension UIViewController: TopViewControllerAccessible {}

extension TopViewControllerAccessible {
    var rootViewController: UIViewController? {
        UIApplication.shared.windows.first {
            $0.isKeyWindow
        }?.rootViewController
    }

    func getTopViewController() -> UIViewController? {
        var topViewController: UIViewController? = rootViewController

        while let presentedViewController = topViewController?.presentedViewController {
            topViewController = presentedViewController
        }

        return topViewController
    }

    func getVisibleViewController() -> UIViewController? {
        guard let rootViewController = rootViewController else {
            return nil
        }

        return getVisibleViewController(rootViewController)
    }

    private func getVisibleViewController(
        _ rootViewController: UIViewController
    ) -> UIViewController? {
        if let presentedViewController = rootViewController.presentedViewController {
            return getVisibleViewController(presentedViewController)
        }

        if let navigationController = rootViewController as? UINavigationController {
            return navigationController.visibleViewController
        }

        if let tabBarController = rootViewController as? UITabBarController {

            if let navigationController = tabBarController.selectedViewController as? UINavigationController {
                let visible = navigationController.visibleViewController

                if visible is UISearchController || visible is UIAlertController {
                    return visible?.presentingViewController ?? visible?.parent
                }

                return visible
            }

            return tabBarController.selectedViewController
        }

        return rootViewController
    }
}
