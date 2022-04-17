import Combine
import UIKit

// MARK: - stored properties & init

final class CombineViewController: UIViewController {
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

    private let subjectModel: SubjectModel = .init()
    private let futureModel: FutureModel = .init()
    private let justModel: JustModel = .init()

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension CombineViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupEvent()
        bindValue()

        subjectModel.executeCurrentSubject()
        subjectModel.executePassthroughSubject()

        justModel.executeNoJust()
        justModel.executeJust()

        /* この時点でFutureのインスタンスのクロージャ処理が実行されます */
        let deferredModel = DeferredModel() /* Future 実行 */

        deferredModel.futurePublisher.sink { value in
            print(value) /* Hello */
        }
        .store(in: &cancellables)

        deferredModel.deferredPublisher.sink { value in
            print(value) /* Deferred 実行, Hello */
        }
        .store(in: &cancellables)
    }
}

// MARK: - private methods

private extension CombineViewController {
    func setupView() {
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

    func setupEvent() {
        countButton.addTarget(
            self,
            action: #selector(tappedButton),
            for: .touchUpInside
        )
    }

    func bindValue() {
        futureModel.$count
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.countLabel.text = String(value)
            }
            .store(in: &cancellables)
    }

    @objc func tappedButton() {
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
}
