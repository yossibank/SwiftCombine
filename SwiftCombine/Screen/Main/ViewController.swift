import Combine
import UIKit

final class ViewController: UIViewController {

    private let countButton: UIButton = {
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

    private let futureModel: FutureModel = .init()

    private var cancellables: Set<AnyCancellable> = .init()

    @objc private func tappedButton() {
        /* コールバック処理にCombineを使わない場合の呼び出し */
//        futureModel.startCounting { [weak self] in
//            self?.view.backgroundColor = .green
//        }

        /* コールバック処理にCombineのFutureを使った場合の呼び出し */
        futureModel.startCounting()
            .sink { [weak self] _ in
                self?.view.backgroundColor = .green
            }
            .store(in: &cancellables)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupEvent()
        bindValue()
    }

    private func setupView() {
        view.addSubview(countButton)
        view.addSubview(countLabel)

        NSLayoutConstraint.activate([
            countButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            countButton.widthAnchor.constraint(equalToConstant: 220),
            countButton.heightAnchor.constraint(equalToConstant: 40),

            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
        ])
    }

    private func setupEvent() {
        countButton.addTarget(
            self,
            action: #selector(tappedButton),
            for: .touchUpInside
        )
    }

    private func bindValue() {
        futureModel.$count
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.countLabel.text = String(value)
            }
            .store(in: &cancellables)
    }
}
