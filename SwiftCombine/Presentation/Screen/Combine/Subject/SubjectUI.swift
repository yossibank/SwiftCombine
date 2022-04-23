import Combine
import UIKit

// MARK: - stored properties

final class SubjectUI {
    private let subjectCurrentLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private let subjectPassthoughLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    var subjectCurrentText: String? {
        didSet {
            if let text = subjectCurrentText {
                subjectCurrentLabel.text = "output: \(text)"
            }
        }
    }

    var subjectPassthoughText: String? {
        didSet {
            if let text = subjectPassthoughText {
                subjectPassthoughLabel.text = "output: \(text)"
            }
        }
    }
}

// MARK: - protocol

extension SubjectUI: UserInterface {
    func setupView(rootView: UIView) {
        rootView.backgroundColor = .systemBackground

        rootView.addSubViews(
            subjectCurrentLabel,
            subjectPassthoughLabel,

            constraints:
                subjectCurrentLabel.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
                subjectCurrentLabel.centerYAnchor.constraint(equalTo: rootView.centerYAnchor),
                subjectPassthoughLabel.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
                subjectPassthoughLabel.centerYAnchor.constraint(equalTo: rootView.centerYAnchor, constant: 100)
        )
    }
}
