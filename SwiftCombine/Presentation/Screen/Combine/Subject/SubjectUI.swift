import Combine
import UIKit

// MARK: - stored properties

final class SubjectUI {
    private let subjectLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    var text: String? {
        didSet {
            if let text = text {
                subjectLabel.text = "output: \(text)"
            }
        }
    }
}

// MARK: - protocol

extension SubjectUI: UserInterface {
    func setupView(rootView: UIView) {
        rootView.backgroundColor = .systemBackground

        rootView.addSubViews(
            subjectLabel,

            constraints:
                subjectLabel.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
                subjectLabel.centerYAnchor.constraint(equalTo: rootView.centerYAnchor)
        )
    }
}
