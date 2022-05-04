import UIKit

final class JokeSearchUI {
    var isShouldLoading: Bool {
        let offset = tableView.contentOffset.y
        let frameSizeHeight = tableView.frame.size.height
        let contentSizeHeight = tableView.contentSize.height
        return offset + frameSizeHeight > contentSizeHeight && tableView.isDragging
    }

    private let tableView = UITableView()

    private var dataSource: UITableViewDiffableDataSource<JokeSearchSection, JokeSearchItem>!
}

// MARK: - internal methods

extension JokeSearchUI {
    func setupTableView(delegate: UITableViewDelegate) {
        dataSource = configureDataSource()

        tableView.register(
            JokeSearchCell.self,
            forCellReuseIdentifier: String(describing: JokeSearchCell.self)
        )

        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.tableFooterView = UIView()

        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }

    func updateDataSource(items: [JokeSearchItem]) {
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<JokeSearchSection, JokeSearchItem>()
        dataSourceSnapshot.appendSections(JokeSearchSection.allCases)
        dataSourceSnapshot.appendItems(items, toSection: .main)
        dataSource.apply(dataSourceSnapshot, animatingDifferences: false)
    }
}

// MARK: - private methods

private extension JokeSearchUI {
    func configureDataSource() -> UITableViewDiffableDataSource<JokeSearchSection, JokeSearchItem> {
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
        item: JokeSearchItem
    ) -> UITableViewCell? {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: JokeSearchCell.self),
                for: indexPath
            ) as? JokeSearchCell
        else {
            return .init()
        }

        cell.configure(item: item)

        return cell
    }
}

// MARK: - protocol

extension JokeSearchUI: UserInterface {
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
