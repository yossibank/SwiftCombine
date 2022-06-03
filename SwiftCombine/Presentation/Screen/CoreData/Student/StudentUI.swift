import Combine
import UIKit

// MARK: - properties & init

final class StudentUI {
    lazy var navButtonTapPublisher = navigationButton.publisher(for: .touchUpInside)

    private let navigationButton = Navigationbutton(title: "部活一覧へ")
    private let tableView = UITableView()

    private(set) var dataSource: UITableViewDiffableDataSource<StudentSection, StudentItem>!
}

// MARK: - internal methods

extension StudentUI {
    func setupTableView(delegate: UITableViewDelegate) {
        dataSource = configureDataSource()

        tableView.register(
            StudentCell.self,
            forCellReuseIdentifier: String(describing: StudentCell.self)
        )

        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView()

        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }

    func updateDataSource(items: [StudentItem]) {
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<StudentSection, StudentItem>()
        dataSourceSnapshot.appendSections(StudentSection.allCases)
        dataSourceSnapshot.appendItems(items, toSection: .main)
        dataSource.apply(dataSourceSnapshot, animatingDifferences: false)
    }
}

// MARK: - private methods

private extension StudentUI {
    func configureDataSource() -> UITableViewDiffableDataSource<StudentSection, StudentItem> {
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
        item: StudentItem
    ) -> UITableViewCell? {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: StudentCell.self),
                for: indexPath
            ) as? StudentCell
        else {
            return .init()
        }

        cell.configure(item: item)
        return cell
    }
}

// MARK: - protocol

extension StudentUI: UserInterface {
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

    func setupNavigationBar(
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem?
    ) {
        navigationItem?.rightBarButtonItem = .init(customView: navigationButton)
    }
}
