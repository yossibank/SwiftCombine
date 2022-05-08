import Combine

// MARK: - properties & init

final class HomeViewModel: ViewModel {
    @Published var isOn: Bool = false

    private var cancellables: Set<AnyCancellable> = .init()

    private let getModel: GetOnboardingModel
    private let setModel: SetOnboardingModel

    init(
        getModel: GetOnboardingModel = Model.Onboarding.Get(),
        setModel: SetOnboardingModel = Model.Onboarding.Set()
    ) {
        self.getModel = getModel
        self.setModel = setModel
    }
}

// MARK: - internal methods

extension HomeViewModel {
    func fetch() {
        getModel.fetch().sink { [weak self] value in
            guard let self = self else { return }
            Logger.debug(message: "PersistedDataHolder.onboardingFinished: \(value)")
            self.isOn = value
        }
        .store(in: &cancellables)
    }

    func set() {
        setModel.set(isOn)
            .sink { _ in }
            .store(in: &cancellables)
    }
}
