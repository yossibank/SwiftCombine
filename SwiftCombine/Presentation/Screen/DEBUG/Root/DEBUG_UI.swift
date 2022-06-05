import Combine
import UIKit

// MARK: - delegate

protocol DEBUG_UI_Delegate: AnyObject {
    func updateServerType(_ type: UserDefaultsEnum.ServerType)
}

// MARK: - properties & init

final class DEBUG_UI {
    private let tableView = UITableView()

    weak var delegate: DEBUG_UI_Delegate!

    private var dataSource: UITableViewDiffableDataSource<DEBUG_Section, DEBUG_Item>!
    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - internal methods

extension DEBUG_UI {
    func setupTableView(delegate: UITableViewDelegate) {
        dataSource = configureDataSource()

        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: String(describing: UITableViewCell.self)
        )

        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()

        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }

        updateDataSource()
    }

    func updateDataSource() {
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<DEBUG_Section, DEBUG_Item>()
        dataSourceSnapshot.appendSections(DEBUG_Section.allCases)

        DEBUG_Section.allCases.forEach {
            dataSourceSnapshot.appendItems($0.items, toSection: $0)
        }

        dataSource.apply(dataSourceSnapshot, animatingDifferences: false)
    }
}

// MARK: - private methods

private extension DEBUG_UI {
    func configureDataSource() -> UITableViewDiffableDataSource<DEBUG_Section, DEBUG_Item> {
        .init(tableView: tableView) { [weak self] tableView, indexPath, item in
            guard let self = self else {
                return .init()
            }

            return self.makeCell(
                tableView: tableView,
                indexPath: indexPath,
                item: item
            )
        }
    }

    func makeCell(
        tableView: UITableView,
        indexPath: IndexPath,
        item: DEBUG_Item
    ) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: UITableViewCell.self),
            for: indexPath
        )

        cell.textLabel?.text = ""
        cell.accessoryView = nil

        switch item {
        case let .development(content):
            switch content {
            case .server:
                let segment = UISegmentedControl(
                    frame: .init(x: 20, y: 0, width: tableView.frame.width - 40, height: 40)
                )

                DEBUG_Development.ServerItem.allCases.enumerated().forEach { index, type in
                    segment.insertSegment(withTitle: type.rawValue, at: index, animated: false)
                }

                segment.selectedIndexPublisher.sink { [weak self] index in
                    AppDataHolder.serverType = .init(rawValue: index) ?? .stage
                    self?.delegate.updateServerType(AppDataHolder.serverType)
                }
                .store(in: &cancellables)

                segment.selectedSegmentIndex = AppDataHolder.serverType.rawValue

                cell.accessoryView = segment
            }

        case let .userDefault(content):
            switch content {
            case .jokeId:
                cell.textLabel?.text = "保存したJoke ID: \(AppDataHolder.jokeId)"
            }

        case let .api(content):
            switch content {
            case .get:
                cell.textLabel?.text = "Joke Get"

            case .random:
                cell.textLabel?.text = "Joke Random"

            case .search:
                cell.textLabel?.text = "Joke Search"

            case .slack:
                cell.textLabel?.text = "Joke Slack"
            }

        case let .coreData(content):
            switch content {
            case .fruit:
                cell.textLabel?.text = "Fruit Entity"

            case .student:
                cell.textLabel?.text = "Student Entity"
            }

        case let .combine(content):
            switch content {
            case .just:
                cell.textLabel?.text = "Just"

            case .subject:
                cell.textLabel?.text = "Subject"

            case .future:
                cell.textLabel?.text = "Future"

            case .deferred:
                cell.textLabel?.text = "Deferred"
            }

        case let .fileManager(content):
            switch content {
            case .someFile:
                cell.textLabel?.text = "SomeFile"
            }
        }

        return cell
    }
}

// MARK: - protocol

extension DEBUG_UI: UserInterface {
    func setupView(rootView: UIView) {
        rootView.backgroundColor = .systemBackground

        rootView.addSubViews(
            tableView,

            constraints:
                tableView.topAnchor.constraint(equalTo: rootView.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor)
        )
    }
}
