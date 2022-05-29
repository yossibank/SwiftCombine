import Combine

extension UsecaseImpl where R == Repos.Onboarding.SetIsFinished, M == NoMapper {
    func set(_ parameter: Bool) -> AnyPublisher<EmptyResponse, Never> {
        toPublisher { promise in
            if let response = resource.request(parameters: parameter) {
                promise(.success(response))
            }
        }
    }
}
