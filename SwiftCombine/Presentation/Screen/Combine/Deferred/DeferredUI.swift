import Combine
import UIKit

// MARK: - properties & init

final class DeferredUI {
    private lazy var futureButton: UIButton = {
        let button = UIButton()
        button.setTitle("Future実行", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        return button
    }()

    private lazy var deferredButton: UIButton = {
        let button = UIButton()
        button.setTitle("Deferred実行", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        return button
    }()

    lazy var futureButtonTapPublisher: UIControl.Publisher<UIButton> = {
        futureButton.publisher(for: .touchUpInside)
    }()

    lazy var deferredButtonTapPublisher: UIControl.Publisher<UIButton> = {
        deferredButton.publisher(for: .touchUpInside)
    }()
}

// MARK: - protocol

extension DeferredUI: UserInterface {
    func setupView(rootView: UIView) {
        rootView.backgroundColor = .systemBackground

        rootView.addSubViews(
            futureButton,
            deferredButton,

            constraints:
                futureButton.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
                futureButton.centerYAnchor.constraint(equalTo: rootView.centerYAnchor, constant: -60),
                futureButton.widthAnchor.constraint(equalToConstant: 220),
                futureButton.heightAnchor.constraint(equalToConstant: 40),

                deferredButton.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
                deferredButton.centerYAnchor.constraint(equalTo: rootView.centerYAnchor, constant: 60),
                deferredButton.widthAnchor.constraint(equalToConstant: 220),
                deferredButton.heightAnchor.constraint(equalToConstant: 40)
        )
    }
}
