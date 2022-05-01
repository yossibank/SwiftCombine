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
        viewModel.fetchAll()
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
            self.viewModel.add()
            self.viewModel.fetchAll()
        }
        .store(in: &cancellables)
    }

    func bindToViewModel() {
        ui.nameTextFieldPublisher
            .assign(to: \.name, on: viewModel)
            .store(in: &cancellables)
    }

    func bindToView() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { state in
                switch state {
                case .standby:
                    Logger.debug(message: "standby")

                case .loading:
                    Logger.debug(message: "loading")

                case let .done(response):
                    Logger.debug(message: "\(response.map(\.name))")

                case let .failed(error):
                    Logger.debug(message: error.localizedDescription)
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - delegate

extension CoreDataViewController: UITableViewDelegate {}
