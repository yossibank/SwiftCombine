import Combine
import UIKit

// MARK: - screen transition management

protocol DEBUG_ViewControllerDelegate: AnyObject {
    func didControllerSelected(item: DEBUG_API)
    func didCoreDataSelected(item: DEBUG_CoreData)
    func didCombineSelected(item: DEBUG_Combine)
}

// MARK: - inejct

extension DEBUG_ViewController: VCInjectable {
    typealias VM = NoViewModel
    typealias UI = DEBUG_UI
}

// MARK: - stored properties

final class DEBUG_ViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!

    weak var delegate: DEBUG_ViewControllerDelegate!
}

// MARK: - override methods

extension DEBUG_ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.delegate = self
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
        header.textLabel?.text = section.rawValue.addSpaceAfterUppercase.uppercased()
        return header
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)

        let section = DEBUG_Section.allCases[indexPath.section]

        switch section {
        case .development, .userDefault:
            break

        case .api:
            let item = DEBUG_API.allCases[indexPath.row]
            delegate.didControllerSelected(item: item)

            guard item == .jokeRandom else {
                return
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.ui.updateDataSource()
            }

        case .coreData:
            let item = DEBUG_CoreData.allCases[indexPath.row]
            delegate.didCoreDataSelected(item: item)

        case .combine:
            let item = DEBUG_Combine.allCases[indexPath.row]
            delegate.didCombineSelected(item: item)
        }
    }
}

extension DEBUG_ViewController: DEBUG_UI_Delegate {
    func changedServerType(_ type: UserDefaultEnumKey.ServerType) {
        (rootViewController as? AppFlowController)?.updateTab(type)
    }
}
