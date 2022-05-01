import Combine

final class HomeViewModel: ViewModel {
    @Published var isOn: Bool = false

    private var cancellables: Set<AnyCancellable> = .init()

    private let getOnboardingModel: GetOnboardingModel
    private let setOnboardingModel: SetOnboardingModel

    init(
        getOnboardingModel: GetOnboardingModel = Model.Onboarding.Get(),
        setOnboardingModel: SetOnboardingModel = Model.Onboarding.Set()
    ) {
        self.getOnboardingModel = getOnboardingModel
        self.setOnboardingModel = setOnboardingModel
    }
}

// MARK: - internal methods

extension HomeViewModel {
    func fetch() {
        getOnboardingModel.fetch().sink { [weak self] value in
            guard let self = self else { return }
            Logger.debug(message: "PersistedDataHolder.onboardingFinished: \(value)")
            self.isOn = value
        }
        .store(in: &cancellables)
    }

    func set() {
        setOnboardingModel.set(isOn)
            .sink { _ in }
            .store(in: &cancellables)
    }
}
