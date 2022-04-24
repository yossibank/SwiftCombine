import UIKit

final class CoreDataUI {
    private let inputTextField = UITextField()
    private let saveButton = UIButton()
    private let tableView = UITableView()

    private lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [inputTextField, saveButton]))

    private var dataSourceSnapshot = NSDiffableDataSourceSnapshot<CoreDataSection, CoreDataItem>()
    private var dataSource: UITableViewDiffableDataSource<CoreDataSection, CoreDataItem>!
}

// MARK: - internal methods

extension CoreDataUI {
    func setupTableView(delegate: UITableViewDelegate, items: [CoreDataItem]) {
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

        dataSourceSnapshot.appendSections(CoreDataSection.allCases)
        dataSourceSnapshot.appendItems(items, toSection: .main)

        dataSource.apply(
            dataSourceSnapshot,
            animatingDifferences: false
        )
    }
}

// MARK: - private methods

private extension CoreDataUI {
    func configureDataSource() -> UITableViewDiffableDataSource<CoreDataSection, CoreDataItem> {
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
        item: CoreDataItem
    ) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: UITableViewCell.self),
            for: indexPath
        )
        cell.textLabel?.text = item.title
        return cell
    }
}

// MARK: - protocol

extension CoreDataUI: UserInterface {
    func setupView(rootView: UIView) {
        rootView.backgroundColor = .systemBackground

        rootView.addSubViews(
            stackView,
            tableView,

            constraints:
                stackView.topAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.topAnchor, constant: 16),
                stackView.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),

                inputTextField.heightAnchor.constraint(equalToConstant: 40),
                saveButton.widthAnchor.constraint(equalToConstant: 200),
                saveButton.heightAnchor.constraint(equalToConstant: 56),

                tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
                tableView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor)
        )
    }
}
