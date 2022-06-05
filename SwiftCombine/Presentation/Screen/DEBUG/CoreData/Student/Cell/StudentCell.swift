import UIKit

// MARK: - properties & init

final class StudentCell: UITableViewCell {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberLabel, nameLabel, ageLabel])
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private let ageLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: - internal methods

extension StudentCell {
    func configure(item: StudentItem) {
        if let clubName = item.clubName {
            nameLabel.text = "\(item.name)   \(clubName)"
        } else {
            nameLabel.text = item.name
        }
        numberLabel.text = "No: \(item.number)"
        ageLabel.text = "年齢: \(item.age)"
    }
}

// MARK: - private methods

private extension StudentCell {
    func setupView() {
        contentView.addSubViews(
            stackView,

            constraints:
                numberLabel.widthAnchor.constraint(equalToConstant: 60),
                ageLabel.widthAnchor.constraint(equalToConstant: 60),

                stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        )
    }
}
