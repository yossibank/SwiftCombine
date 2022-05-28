import Combine
import UIKit

protocol StudentViewControllerDelegate: AnyObject {
    func showClubScreen()
}

// MARK: - inejct

extension StudentViewController: VCInjectable {
    typealias VM = StudentViewModel
    typealias UI = StudentUI
    typealias R = NoRouting
}

// MARK: - properties & init

final class StudentViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
    var routing: R!

    weak var delegate: StudentViewControllerDelegate!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension StudentViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()
        ui.setupView(rootView: view)
        ui.setupNavigationBar(
            navigationBar: navigationController?.navigationBar,
            navigationItem: navigationItem
        )
        ui.setupTableView(delegate: self, viewModel: viewModel)
        setupEvent()
        bindToViewModel()
        bindToView()
    }
}

// MARK: - private methods

private extension StudentViewController {
    func setupEvent() {
        ui.saveButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }

            self.ui.clear()
            self.viewModel.add()
            self.viewModel.fetch()
        }
        .store(in: &cancellables)

        ui.navButtonTapPublisher.sink { [weak self] _ in
            self?.delegate.showClubScreen()
        }
        .store(in: &cancellables)
    }

    func bindToViewModel() {
        ui.nameTextFieldPublisher
            .removeDuplicates()
            .assign(to: \.name, on: viewModel)
            .store(in: &cancellables)

        ui.ageTextFieldPublisher
            .removeDuplicates()
            .assign(to: \.age, on: viewModel)
            .store(in: &cancellables)

        ui.numberTextFieldPublisher
            .removeDuplicates()
            .assign(to: \.number, on: viewModel)
            .store(in: &cancellables)
    }

    func bindToView() {
        viewModel.isEnabled
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEnabled in
                self?.ui.isValidButton = isEnabled
            }
            .store(in: &cancellables)

        viewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.ui.updateDataSource(items: items)
            }
            .store(in: &cancellables)

        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { state in
                switch state {
                case .standby:
                    Logger.debug(message: "standby")

                case .loading:
                    Logger.debug(message: "loading")

                case let .done(entity):
                    Logger.debug(message: "\(entity.map(\.name))")

                case let .failed(error):
                    Logger.debug(message: error.localizedDescription)
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - delegate

extension StudentViewController: UITableViewDelegate {}
