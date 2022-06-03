import Combine

extension UsecaseImpl where R == Repos.Local.Club, M == ClubMapper {
    func fetch() -> AnyPublisher<[ClubEntity], Never> {
        toPublisher { promise in
            guard let response = resource.request() else {
                return
            }

            let entity = response.map(mapper.convert)
            promise(.success(entity))
        }
    }
}
