import Combine

extension UsecaseImpl where R == Repos.Onboarding.SetIsFinished, M == NoMapper {
    func set(_ parameter: Bool) -> AnyPublisher<EmptyResponse, Never> {
        toPublisher { promise in
            if let response = repository.request(parameters: parameter) {
                promise(.success(response))
            }
        }
    }
}
