import Combine

extension ModelImpl where R == Repos.CoreDataFruit, M == FruitMapper {
    func fetchAll() -> AnyPublisher<[FruitEntity], CoreDataError> {
        toPublisher { promise in
            repository.fetchAll { result in
                switch result {
                case let .success(response):
                    let entity = mapper.convert(response: response)
                    promise(.success(entity))

                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }

    func add(_ fruitEntity: FruitEntity) {
        let coreDataEntity: Fruit = repository.create()
        coreDataEntity.name = fruitEntity.name
        repository.add(coreDataEntity)
    }
}
