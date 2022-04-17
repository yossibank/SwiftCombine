import Combine
import UIKit

// MARK: - inejct

extension DEBUG_ViewController: VCInjectable {
    typealias VM = NoViewModel
    typealias UI = DEBUG_UI
}

// MARK: - stored properties

final class DEBUG_ViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
}

// MARK: - override methods

extension DEBUG_ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setupView(rootView: view)
        ui.setupTableView(delegate: self)
    }
}

// MARK: - delegate

extension DEBUG_ViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let header = UITableViewHeaderFooterView()
        let section = DEBUG_Section.allCases[section]

        if #available(iOS 14.0, *) {
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .gray
            header.backgroundConfiguration = backgroundConfig
        } else {
            header.contentView.backgroundColor = .gray
        }

        header.textLabel?.textColor = .white
        header.textLabel?.text = section.rawValue.uppercased()
        return header
    }
}
