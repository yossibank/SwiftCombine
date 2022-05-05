import Combine

extension ModelImpl where R == Repos.Local.ClubCoreData, M == ClubMapper {
    func fetch() -> AnyPublisher<[ClubEntity], CoreDataError> {
        toPublisher { promise in
            repository.fetch() { result in
                switch result {
                case let .success(response):
                    let entities = response.map(mapper.convert)
                    promise(.success(entities))

                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }
}
