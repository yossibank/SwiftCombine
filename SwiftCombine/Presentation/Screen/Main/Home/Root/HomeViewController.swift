import Combine
import UIKit

// MARK: - inject

extension HomeViewController: VCInjectable {
    typealias VM = HomeViewModel
    typealias UI = NoUserInterface
    typealias R = NoRouting
}

// MARK: - properties & init

final class HomeViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
    var routing: R!

    private let mainView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private let switcher: UISwitch = {
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UISwitch())

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()
        setupView()
        bindToViewModel()
        bindToView()
    }
}

// MARK: - private methods

private extension HomeViewController {
    func setupView() {
        view.addSubViews(
            mainView,
            switcher,

            constraints:
                mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

                switcher.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                switcher.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        )
    }
    
    func bindToViewModel() {
        switcher.isOnPublisher
            .assign(to: \.isOn, on: viewModel)
            .store(in: &cancellables)
    }

    func bindToView() {
        viewModel.$isOn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.switcher.isOn = value
                self?.mainView.backgroundColor = value ? .yellow : . green
            }
            .store(in: &cancellables)

        switcher.isOnPublisher.sink { [weak self] value in
            self?.viewModel.set()
        }
        .store(in: &cancellables)
    }
}
