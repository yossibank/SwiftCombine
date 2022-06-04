import Combine
import UIKit

// MARK: - inject

extension SubjectViewController: VCInjectable {
    typealias VM = SubjectViewModel
    typealias UI = NoUserInterface
    typealias R = NoRouting
}

// MARK: - properties & init

final class SubjectViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
    var routing: R!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension SubjectViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        observation()
    }
}

// MARK: - private methods

private extension SubjectViewController {
    func observation() {
        viewModel.executeCurrentSubject()
        /** 実行結果:
         * []
         * [1]
         * [1, 2]
         * [1, 2, 3]
         */

        viewModel.executePassthroughSubject()
        /** 実行結果:
         * 1
         * finished
         */
    }
}
