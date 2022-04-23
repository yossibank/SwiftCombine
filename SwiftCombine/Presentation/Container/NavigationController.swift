import UIKit

// MARK: - override methods

final class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setupBackGroundColor(color: .systemBackground)
    }
}

// MARK: - extension

extension UINavigationBar {
    func setupBackGroundColor(color: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        appearance.shadowColor = .lightGray.withAlphaComponent(0.5)
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
    }
}
