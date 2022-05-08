import Combine
import UIKit

// MARK: - inject

extension SomeFileViewController: VCInjectable {
    typealias VM = SomeFileViewModel
    typealias UI = SomeFileUI
}

// MARK: - properties & init

final class SomeFileViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension SomeFileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()
        ui.setupView(rootView: view)
        setupEvent()
        bindToViewModel()
        bindToView()
    }
}

// MARK: - private methods

private extension SomeFileViewController {
    func setupEvent() {
        ui.saveButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.set()
        }
        .store(in: &cancellables)
    }

    func bindToViewModel() {
        ui.textField1Publisher
            .assign(to: \.text1, on: viewModel)
            .store(in: &cancellables)

        ui.textField2Publisher
            .assign(to: \.text2, on: viewModel)
            .store(in: &cancellables)

        ui.textField3Publisher
            .assign(to: \.text3, on: viewModel)
            .store(in: &cancellables)
    }

    func bindToView() {
        viewModel.$someFile
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                self.ui.someFile = value
            }
            .store(in: &cancellables)
    }
}
