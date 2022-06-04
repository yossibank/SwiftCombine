import Combine

struct OnboardingModel: Model {
    func fetch() -> AnyPublisher<Bool, Never> {
        toPublisher { promise in
            promise(.success(PersistedDataHolder.onboardingFinished))
        }
    }

    func set(_ value: Bool) {
        PersistedDataHolder.onboardingFinished = value
    }
}
