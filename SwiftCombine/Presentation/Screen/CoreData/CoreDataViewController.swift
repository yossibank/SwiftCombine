import Combine
import UIKit

// MARK: - inject

extension CoreDataViewController: VCInjectable {
    typealias VM = NoViewModel
    typealias UI = CoreDataUI
}

// MARK: - stored properties

final class CoreDataViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
}

// MARK: - override methods

extension CoreDataViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setupView(rootView: view)
        ui.setupTableView(delegate: self, items: [])
    }
}

// MARK: - delegate

extension CoreDataViewController: UITableViewDelegate {}
