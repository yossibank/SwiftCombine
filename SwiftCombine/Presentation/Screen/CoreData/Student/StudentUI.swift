import Combine
import UIKit

// MARK: - properties & init

final class StudentUI {
    private lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 16
        return $0
    }(UIStackView(arrangedSubviews: [infoStackView, saveButton]))

    private lazy var infoStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 8
        return $0
    }(UIStackView(arrangedSubviews: [nameTextField, ageTextField, numberTextField]))

    private let nameTextField: UITextField = {
        $0.placeholder = "生徒名入力"
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())

    private let ageTextField: UITextField = {
        $0.placeholder = "年齢入力"
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())

    private let numberTextField: UITextField = {
        $0.placeholder = "No入力"
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

    private let navigationButton = Navigationbutton(title: "部活一覧へ")
    private let tableView = UITableView()

    var isValidButton: Bool = false {
        didSet {
            saveButton.isEnabled = isValidButton
            saveButton.alpha = isValidButton ? 1.0 : 0.5
        }
    }

    lazy var nameTextFieldPublisher: AnyPublisher<String, Never> = {
        nameTextField.textDidChangePublisher
    }()

    lazy var ageTextFieldPublisher: AnyPublisher<String, Never> = {
        ageTextField.textDidChangePublisher
    }()

    lazy var numberTextFieldPublisher: AnyPublisher<String, Never> = {
        numberTextField.textDidChangePublisher
    }()

    lazy var saveButtonTapPublisher: UIControl.Publisher<UIButton> = {
        saveButton.publisher(for: .touchUpInside)
    }()

    lazy var navButtonTapPublisher: UIControl.Publisher<Navigationbutton> = {
        navigationButton.publisher(for: .touchUpInside)
    }()

    private(set) var dataSource: StudentDataSource!
}

// MARK: - internal methods

extension StudentUI {
    func setupTableView(delegate: UITableViewDelegate, viewModel: StudentViewModel) {
        dataSource = configureDataSource()
        dataSource.inject(viewModel)

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

    func clear() {
        nameTextField.text = nil
        ageTextField.text = nil
        numberTextField.text = nil
        isValidButton = false
    }
}

// MARK: - private methods

private extension StudentUI {
    func configureDataSource() -> StudentDataSource {
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
            stackView,
            tableView,

            constraints:
                stackView.topAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.topAnchor, constant: 40),
                stackView.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
                saveButton.heightAnchor.constraint(equalToConstant: 56),

                tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
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

// MARK: - dataSource

final class StudentDataSource: UITableViewDiffableDataSource<StudentSection, StudentItem> {
    private var viewModel: StudentViewModel!

    func inject(_ viewModel: StudentViewModel) {
        self.viewModel = viewModel
    }

    override func tableView(
        _ tableView: UITableView,
        canEditRowAt indexPath: IndexPath
    ) -> Bool {
        true
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        let item = viewModel.items[indexPath.row]
        viewModel.delete(name: item.name)
        viewModel.fetch()
    }
}
