import UIKit

final class StudentRouting: Routing {
    weak var viewController: UIViewController!
}

extension StudentRouting {
    func showClubScreen() {
        let vc = AppControllers.CoreData.Club()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
