import Combine
import UIKit

// MARK: - inject

extension DeferredViewController: VCInjectable {
    typealias VM = DeferredViewModel
    typealias UI = DeferredUI
    typealias R = NoRouting
}

// MARK: - properties & init

final class DeferredViewController: UIViewController {
    // インスタンスが生成された時点でDeferredViewModel内のfuturePublisherのprint文が実行されます("Future実行")
    var viewModel: VM!
    var ui: UI!
    var routing: R!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension DeferredViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setupView(rootView: view)
        setupEvent()
    }
}

// MARK: - private methods

private extension DeferredViewController {
    func setupEvent() {
        ui.futureButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }

            self.viewModel.futurePublisher.sink { value in
                print(value)
            }.store(in: &self.cancellables)
            /** 出力結果:
             * Hello
             */
        }
        .store(in: &cancellables)

        ui.deferredButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }

            self.viewModel.deferredPublisher.sink { value in
                print(value)
            }.store(in: &self.cancellables)
            /** 出力結果:
             * Deferred実行
             * Hello
             */
        }
        .store(in: &cancellables)
    }
}
