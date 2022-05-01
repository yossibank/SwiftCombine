import Combine

extension ModelImpl where R == Repos.Onboarding.SetIsFinished {
    func set(_ parameter: Bool) -> AnyPublisher<EmptyResponse, Never> {
        toPublisher { promise in
            if let response = repository.request(parameters: parameter) {
                promise(.success(response))
            }
        }
    }
}
