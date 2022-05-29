import Combine

extension UsecaseImpl where R == Repos.Onboarding.GetIsFinished, M == NoMapper {
    func fetch() -> AnyPublisher<Bool, Never> {
        toPublisher { promise in
            if let response = resource.request() {
                promise(.success(response))
            }
        }
    }
}
