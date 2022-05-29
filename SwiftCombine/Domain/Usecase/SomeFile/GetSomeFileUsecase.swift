import Combine

extension UsecaseImpl where R == Repos.SomeFile.Get, M == NoMapper {
    func fetch() -> AnyPublisher<[String], Never> {
        toPublisher { promise in
            if let response = resource.request() {
                promise(.success(response))
            }
        }
    }
}
