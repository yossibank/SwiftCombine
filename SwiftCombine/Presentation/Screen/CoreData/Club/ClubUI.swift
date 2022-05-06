import Combine
import UIKit

// MARK: - properties & init

final class ClubUI {
    private let tableView = UITableView()

    private var dataSource: UITableViewDiffableDataSource<ClubSection, ClubItem>!
}

// MARK: - internal methods

extension ClubUI {
    func setupTableView(delegate: UITableViewDelegate) {
        dataSource = configureDataSource()

        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: String(describing: UITableViewCell.self)
        )

        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView()

        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }

    func updateDataSource(items: [ClubItem]) {
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<ClubSection, ClubItem>()
        dataSourceSnapshot.appendSections(ClubSection.allCases)
        dataSourceSnapshot.appendItems(items, toSection: .main)
        dataSource.apply(dataSourceSnapshot, animatingDifferences: false)
    }
}

// MARK: - private methods

private extension ClubUI {
    func configureDataSource() -> UITableViewDiffableDataSource<ClubSection, ClubItem> {
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
        item: ClubItem
    ) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: UITableViewCell.self),
            for: indexPath
        )
        let studentName = item.students.isEmpty
            ? ""
            : item.students.map(\.name).joined(separator: ",")

        cell.textLabel?.text = "\(item.name)   \(studentName)"
        return cell
    }
}

// MARK: - protocol

extension ClubUI: UserInterface {
    func setupView(rootView: UIView) {
        rootView.backgroundColor = .systemBackground

        rootView.addSubViews(
            tableView,

            constraints:
                tableView.topAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor)
        )
    }
}
