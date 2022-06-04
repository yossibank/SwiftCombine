import UIKit

final class JokeRandomUI {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textView])
        return stackView
    }()

    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = .italicSystemFont(ofSize: 16)
        textView.textColor = .red
        return textView
    }()

    var text: String = "" {
        didSet {
            textView.text = text
        }
    }
}

// MARK: - protocol

extension JokeRandomUI: UserInterface {
    func setupView(rootView: UIView) {
        rootView.backgroundColor = .systemBackground
        
        rootView.addSubViews(
            stackView,

            constraints:
                stackView.topAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.topAnchor, constant: 20),
                stackView.bottomAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.bottomAnchor),
                stackView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -16)
        )
    }
}
