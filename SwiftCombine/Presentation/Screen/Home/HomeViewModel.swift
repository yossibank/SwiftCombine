import Combine

// MARK: - properties & init

final class HomeViewModel: ViewModel {
    @Published var isOn: Bool = false

    private var cancellables: Set<AnyCancellable> = .init()

    private let model: OnboardingModel

    init(model: OnboardingModel = OnboardingModel()) {
        self.model = model
    }
}

// MARK: - internal methods

extension HomeViewModel {
    func fetch() {
        model.fetch().sink { [weak self] value in
            guard let self = self else { return }
            Logger.debug(message: "PersistedDataHolder.onboardingFinished: \(value)")
            self.isOn = value
        }
        .store(in: &cancellables)
    }

    func set() {
        model.set(isOn)
    }
}
