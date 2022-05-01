import Combine

extension ModelImpl where R == Repos.CoreData.Fruit {
    func fetchAll() -> AnyPublisher<[FruitEntity], CoreDataError> {
        toPublisher { promise in
            repository.fetchAll { result in
                switch result {
                case let .success(response):
                    promise(.success(response))

                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }

    func add(fruitName: String) {
        let entity: FruitEntity = repository.entity()
        entity.name = fruitName
        repository.add(entity)
    }
}
