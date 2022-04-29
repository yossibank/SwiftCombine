import Combine
import UIKit

// MARK: - inject

extension CoreDataViewController: VCInjectable {
    typealias VM = CoreDataViewModel
    typealias UI = CoreDataUI
}

// MARK: - stored properties

final class CoreDataViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension CoreDataViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()
        ui.setupView(rootView: view)
        ui.setupTableView(delegate: self)
        setupEvent()
        bindToViewModel()
        bindToView()
    }
}

// MARK: - private methods

private extension CoreDataViewController {
    func setupEvent() {
        ui.saveButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }

            self.ui.clearText()
            self.viewModel.save()
            self.viewModel.fetch()
        }
        .store(in: &cancellables)
    }

    func bindToViewModel() {
        ui.nameTextFieldPublisher
            .assign(to: \.name, on: viewModel)
            .store(in: &cancellables)
    }

    func bindToView() {
        viewModel.$items
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] items in
                self?.ui.updateDataSource(items: items)
            }
            .store(in: &cancellables)
    }
}

// MARK: - delegate

extension CoreDataViewController: UITableViewDelegate {}
