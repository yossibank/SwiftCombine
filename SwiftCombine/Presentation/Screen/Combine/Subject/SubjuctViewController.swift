import Combine
import UIKit

// MARK: - inject

extension SubjectViewController: VCInjectable {
    typealias VM = SubjectViewModel
    typealias UI = SubjectUI
}

// MARK: - stored properties & init

final class SubjectViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension SubjectViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setupView(rootView: view)
        bindToView()
        observation()
    }
}

// MARK: - private methods

private extension SubjectViewController {
    func bindToView() {
        /* sinkメソッドを使用してPublisherを購読する */
        viewModel.currentSubject.sink { [weak self] value in
            self?.ui.subjectCurrentText = value.map { String($0) }.joined(separator: ",")
        }
        .store(in: &cancellables)

        /* sinkメソッドを使用してPublisherを購読する */
        viewModel.passthroughSubject.sink { completion in
            switch completion {
                case .finished:
                    print("finished")

                case .failure: // Neverはエラーを発生させないため本来は不要
                    print("failure")
            }
        } receiveValue: { [weak self] value in
            self?.ui.subjectPassthoughText = String(value)
        }
        .store(in: &cancellables)
    }
    
    func observation() {
        viewModel.executeCurrentSubject()
        viewModel.executePassthroughSubject()
    }
}
