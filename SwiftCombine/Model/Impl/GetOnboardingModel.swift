import Combine

extension ModelImpl where R == Repos.Onboarding.GetIsFinished {
    func fetch() -> AnyPublisher<Bool, Never> {
        toPublisher { promise in
            if let response = repository.request() {
                promise(.success(response))
            }
        }
    }
}
