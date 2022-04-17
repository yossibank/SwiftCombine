import Combine
import UIKit

// MARK: - inject

extension CombineViewController: VCInjectable {
    typealias VM = NoViewModel
    typealias UI = CombineUI
}

// MARK: - stored properties & init

final class CombineViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!

    private let subjectModel: SubjectModel = .init()
    private let futureModel: FutureModel = .init()
    private let justModel: JustModel = .init()

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension CombineViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        ui.setupView(rootView: view)
        ui.delegate = self

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
    func bindValue() {
        futureModel.$count
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.ui.setCountText(String(value))
            }
            .store(in: &cancellables)
    }
}

// MARK: - delegate

extension CombineViewController: CombineDelegate {
    func tappedCountButton() {
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
