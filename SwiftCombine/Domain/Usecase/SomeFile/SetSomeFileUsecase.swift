import Combine

extension UsecaseImpl where R == Repos.SomeFile.Set, M == NoMapper {
    func set(_ parameter: [String]) -> AnyPublisher<EmptyResponse, Never> {
        toPublisher { promise in
            if let response = resource.request(parameters: parameter) {
                promise(.success(response))
            }
        }
    }
}
