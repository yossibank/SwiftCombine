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
        observation()
    }
}

// MARK: - private methods

private extension SubjectViewController {
    func observation() {
        viewModel.executeCurrentSubject()
        viewModel.executePassthroughSubject()
    }
}
