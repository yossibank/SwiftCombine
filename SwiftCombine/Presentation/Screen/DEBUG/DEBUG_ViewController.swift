import Combine
import UIKit

// MARK: - inejct

extension DEBUG_ViewController: VCInjectable {
    typealias VM = NoViewModel
    typealias UI = DEBUG_UI
    typealias R = DEBUG_Routing
}

// MARK: - properties & init

final class DEBUG_ViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
    var routing: R! { didSet { routing.viewController = self } }
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
            routing.showJokeScreen(item: item)

            guard item == .random else {
                return
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.ui.updateDataSource()
            }

        case .coreData:
            let item = DEBUG_CoreData.allCases[indexPath.row]
            routing.showCoreDataScreen(item: item)

        case .combine:
            let item = DEBUG_Combine.allCases[indexPath.row]
            routing.showCombineScreen(item: item)

        case .fileManager:
            let item = DEBUG_FileStorage.allCases[indexPath.row]
            routing.showFileStorageScreen(item: item)
        }
    }
}

extension DEBUG_ViewController: DEBUG_UI_Delegate {
    func updateServerType(_ type: UserDefaultEnumKey.ServerType) {
        routing.update(type)
    }
}
