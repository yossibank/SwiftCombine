import UIKit

final class JokeSearchCell: UITableViewCell {
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private let jokeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [idLabel, jokeLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
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

extension JokeSearchCell {
    func configure(item: JokeSearchItem) {
        idLabel.text = "ID: \(item.id)"
        jokeLabel.text = item.joke
    }
}

// MARK: - private methods

private extension JokeSearchCell {
    func setupView() {
        contentView.addSubViews(
            stackView,

            constraints:
                stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        )
    }
}
