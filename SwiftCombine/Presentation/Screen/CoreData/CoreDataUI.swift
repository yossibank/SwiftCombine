import Combine
import UIKit

final class CoreDataUI {
    private let inputTextField: UITextField = {
        $0.placeholder = "名前入力"
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())

    private let saveButton: UIButton = {
        $0.setTitle("保存する", for: .normal)
        $0.setTitleColor(.red, for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.blue.cgColor
        return $0
    }(UIButton())

    private let tableView = UITableView()

    private lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 32
        return $0
    }(UIStackView(arrangedSubviews: [inputTextField, saveButton]))

    private var dataSource: UITableViewDiffableDataSource<CoreDataSection, CoreDataItem>!

    lazy var nameTextFieldPublisher: AnyPublisher<String, Never> = {
        inputTextField.textDidChangePublisher
    }()

    lazy var saveButtonTapPublisher: UIControl.Publisher<UIButton> = {
        saveButton.publisher(for: .touchUpInside)
    }()
}

// MARK: - internal methods

extension CoreDataUI {
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

    func updateDataSource(items: [CoreDataItem]) {
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<CoreDataSection, CoreDataItem>()
        dataSourceSnapshot.appendSections(CoreDataSection.allCases)
        dataSourceSnapshot.appendItems(items, toSection: .main)
        dataSource.apply(dataSourceSnapshot, animatingDifferences: false)
    }

    func clearText() {
        inputTextField.text = nil
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
                stackView.topAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.topAnchor, constant: 40),
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
