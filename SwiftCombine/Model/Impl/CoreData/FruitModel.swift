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

    func add(fruitName: String) {
        let entity: Fruit = repository.entity()
        entity.name = fruitName
        repository.add(entity)
    }
}
