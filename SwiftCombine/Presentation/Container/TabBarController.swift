import UIKit

// MARK: - override methods

final class TabBarController: UITabBarController {
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
}
