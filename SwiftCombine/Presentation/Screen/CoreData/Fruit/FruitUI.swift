import Combine
import UIKit

// MARK: - properties & init

final class FruitUI {
    private lazy var stackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 32
        return $0
    }(UIStackView(arrangedSubviews: [addStackView, deleteStackView]))

    private lazy var addStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 32
        return $0
    }(UIStackView(arrangedSubviews: [addTextField, addButton]))

    private lazy var deleteStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 32
        return $0
    }(UIStackView(arrangedSubviews: [deleteTextField, deleteButton]))

    private let addTextField: UITextField = {
        $0.placeholder = "保存する名前入力"
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())

    private let deleteTextField: UITextField = {
        $0.placeholder = "削除する名前入力"
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())

    private let addButton: UIButton = {
        $0.setTitle("保存する", for: .normal)
        $0.setTitleColor(.red, for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.blue.cgColor
        return $0
    }(UIButton())

    private let deleteButton: UIButton = {
        $0.setTitle("削除する", for: .normal)
        $0.setTitleColor(.yellow, for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.green.cgColor
        return $0
    }(UIButton())

    private let tableView = UITableView()

    var isValidAddButton: Bool = false {
        didSet {
            addButton.isEnabled = isValidAddButton
            addButton.alpha = isValidAddButton ? 1.0 : 0.5
        }
    }

    var isValidDeleteButton: Bool = false {
        didSet {
            deleteButton.isEnabled = isValidDeleteButton
            deleteButton.alpha = isValidDeleteButton ? 1.0 : 0.5
        }
    }

    lazy var addTextFieldPublisher: AnyPublisher<String, Never> = {
        addTextField.textDidChangePublisher
    }()

    lazy var deleteTextFieldPublisher: AnyPublisher<String, Never> = {
        deleteTextField.textDidChangePublisher
    }()

    lazy var addButtonTapPublisher: UIControl.Publisher<UIButton> = {
        addButton.publisher(for: .touchUpInside)
    }()

    lazy var deleteButtonTapPublisher: UIControl.Publisher<UIButton> = {
        deleteButton.publisher(for: .touchUpInside)
    }()

    private var dataSource: UITableViewDiffableDataSource<FruitSection, FruitItem>!
    private var cancellables: Set<AnyCancellable> = .init()    
}

// MARK: - internal methods

extension FruitUI {
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

    func updateDataSource(items: [FruitItem]) {
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<FruitSection, FruitItem>()
        dataSourceSnapshot.appendSections(FruitSection.allCases)
        dataSourceSnapshot.appendItems(items, toSection: .main)
        dataSource.apply(dataSourceSnapshot, animatingDifferences: false)
    }

    func clear() {
        addTextField.text = nil
        deleteTextField.text = nil
        isValidAddButton = false
        isValidDeleteButton = false
    }

    func bindUI() {
        addTextFieldPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self = self else { return }
                self.isValidAddButton = !text.isEmpty
            }
            .store(in: &cancellables)

        deleteTextFieldPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self = self else { return }
                self.isValidDeleteButton = !text.isEmpty
            }
            .store(in: &cancellables)
    }
}

// MARK: - private methods

private extension FruitUI {
    func configureDataSource() -> UITableViewDiffableDataSource<FruitSection, FruitItem> {
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
        item: FruitItem
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

extension FruitUI: UserInterface {
    func setupView(rootView: UIView) {
        rootView.backgroundColor = .systemBackground

        rootView.addSubViews(
            stackView,
            tableView,

            constraints:
                stackView.topAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.topAnchor, constant: 40),
                stackView.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),

                addTextField.heightAnchor.constraint(equalToConstant: 40),
                deleteTextField.heightAnchor.constraint(equalToConstant: 40),
                addButton.heightAnchor.constraint(equalToConstant: 56),
                deleteButton.heightAnchor.constraint(equalToConstant: 56),

                tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
                tableView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor)
        )

        clear()
    }
}
