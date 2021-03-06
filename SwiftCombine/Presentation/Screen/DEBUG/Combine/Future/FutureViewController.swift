import Combine
import UIKit

// MARK: - inject

extension FutureViewController: VCInjectable {
    typealias VM = FutureViewModel
    typealias UI = FutureUI
    typealias R = NoRouting
}

// MARK: - properties & init

final class FutureViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
    var routing: R!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension FutureViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setupView(rootView: view)
        setupEvent()
        bindToView()
    }
}

// MARK: - private methods

private extension FutureViewController {
    func setupEvent() {
        ui.countButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }

            // コールバック処理にCombineを使わない場合の呼び出し
//            self.viewModel.startCounting { [weak self] in
//                self?.view.backgroundColor = .green
//            }

            // コールバック処理にCombineのFutureを使った場合の呼び出し
            self.viewModel.startCounting()
                .sink { [weak self] _ in
                    self?.view.backgroundColor = .green
                }
                .store(in: &self.cancellables)
        }
        .store(in: &cancellables)
    }

    func bindToView() {
        viewModel.$count
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.ui.text = String(value)
            }
            .store(in: &cancellables)
    }
}
