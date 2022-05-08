import Combine
import UIKit

// MARK: - properties & init

final class SomeFileUI {
    private lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 32
        return $0
    }(UIStackView(arrangedSubviews: [label, textField1, textField2, textField3, saveButton]))

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()

    private let textField1: UITextField = {
        $0.placeholder = "保存する内容入力"
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())

    private let textField2: UITextField = {
        $0.placeholder = "保存する内容入力"
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())

    private let textField3: UITextField = {
        $0.placeholder = "保存する内容入力"
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

    var someFile: [String] = [] {
        didSet {
            label.text = someFile.joined(separator: ",")
        }
    }

    lazy var textField1Publisher: AnyPublisher<String, Never> = {
        textField1.textDidChangePublisher
    }()

    lazy var textField2Publisher: AnyPublisher<String, Never> = {
        textField2.textDidChangePublisher
    }()

    lazy var textField3Publisher: AnyPublisher<String, Never> = {
        textField3.textDidChangePublisher
    }()

    lazy var saveButtonTapPublisher: UIControl.Publisher<UIButton> = {
        saveButton.publisher(for: .touchUpInside)
    }()
}

// MARK: - internal methods

extension SomeFileUI {
    func clear() {
        textField1.text = nil
        textField2.text = nil
        textField3.text = nil
    }
}

// MARK: - protocol

extension SomeFileUI: UserInterface {
    func setupView(rootView: UIView) {
        rootView.backgroundColor = .systemBackground

        rootView.addSubViews(
            stackView,

            constraints:
                stackView.centerYAnchor.constraint(equalTo: rootView.centerYAnchor),
                stackView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: 32),
                stackView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -32),

                textField1.heightAnchor.constraint(equalToConstant: 40),
                textField2.heightAnchor.constraint(equalToConstant: 40),
                textField3.heightAnchor.constraint(equalToConstant: 40),
                saveButton.heightAnchor.constraint(equalToConstant: 56)
        )
    }
}
