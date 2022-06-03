import Combine

extension UsecaseImpl where R == Repos.Local.Fruit, M == FruitMapper {
    func fetch() -> AnyPublisher<[FruitEntity], Never> {
        toPublisher { promise in
            guard let response = resource.request() else {
                return
            }

            let entity = response.map(mapper.convert)
            promise(.success(entity))
        }
    }
}
