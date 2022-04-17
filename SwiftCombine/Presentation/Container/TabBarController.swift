import UIKit

// MARK: - override methods

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = .systemBackground
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        } else {
            tabBar.isTranslucent = false
            tabBar.barTintColor = .systemBackground
        }
    }
}
