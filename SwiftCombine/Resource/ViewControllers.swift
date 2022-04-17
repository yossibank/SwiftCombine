import UIKit

struct AppControllers {
    static func api() -> APIViewController {
        let vc = APIViewController()
        vc.title = "API"
        return vc
    }

    static func combine() -> CombineViewController {
        let vc = CombineViewController()
        vc.title = "Combine"
        return vc
    }

    static func home() -> HomeViewController {
        let vc = HomeViewController()
        vc.title = "Home"
        return vc
    }
}
