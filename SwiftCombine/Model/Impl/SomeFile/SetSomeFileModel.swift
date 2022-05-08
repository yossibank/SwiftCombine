import Combine

extension ModelImpl where R == Repos.SomeFile.Set, M == NoMapper {
    func set(_ parameter: [String]) -> AnyPublisher<EmptyResponse, Never> {
        toPublisher { promise in
            if let response = repository.request(parameters: parameter) {
                promise(.success(response))
            }
        }
    }
}
