import Combine
import UIKit

// MARK: - stored properties

final class CombineUI {
    private lazy var countButton: UIButton = {
        let button = UIButton()
        button.setTitle("20カウントで背景色変わる", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var countButtonTapPublisher: UIControl.Publisher<UIButton> = {
        countButton.publisher(for: .touchUpInside)
    }()
}

// MARK: - internal methods

extension CombineUI {
    func setCountText(_ text: String?) {
        countLabel.text = text
    }
}

// MARK: - protocol

extension CombineUI: UserInterface {
    func setupView(rootView: UIView) {
        rootView.addSubview(countButton)
        rootView.addSubview(countLabel)

        NSLayoutConstraint.activate([
            countButton.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
            countButton.centerYAnchor.constraint(equalTo: rootView.centerYAnchor),
            countButton.widthAnchor.constraint(equalToConstant: 220),
            countButton.heightAnchor.constraint(equalToConstant: 40),

            countLabel.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: rootView.centerYAnchor, constant: 100)
        ])
    }
}
