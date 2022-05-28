import Combine

// MARK: - properties & init

final class HomeViewModel: ViewModel {
    @Published var isOn: Bool = false

    private var cancellables: Set<AnyCancellable> = .init()

    private let getUsecase: GetOnboardingUsecase
    private let setUsecase: SetOnboardingUsecase

    init(
        getUsecase: GetOnboardingUsecase = Domain.Usecase.Onboarding.Get(),
        setUsecase: SetOnboardingUsecase = Domain.Usecase.Onboarding.Set()
    ) {
        self.getUsecase = getUsecase
        self.setUsecase = setUsecase
    }
}

// MARK: - internal methods

extension HomeViewModel {
    func fetch() {
        getUsecase.fetch().sink { [weak self] value in
            guard let self = self else { return }
            Logger.debug(message: "PersistedDataHolder.onboardingFinished: \(value)")
            self.isOn = value
        }
        .store(in: &cancellables)
    }

    func set() {
        setUsecase.set(isOn)
            .sink { _ in }
            .store(in: &cancellables)
    }
}
