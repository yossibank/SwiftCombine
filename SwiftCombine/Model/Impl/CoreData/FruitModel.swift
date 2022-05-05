import Combine
import Foundation

extension ModelImpl where R == Repos.CoreDataFruit, M == FruitMapper {
    func fetch() -> AnyPublisher<[FruitEntity], CoreDataError> {
        toPublisher { promise in
            repository.fetch() { result in
                switch result {
                case let .success(response):
                    let entities = response.map { mapper.convert(response: $0) }
                    promise(.success(entities))

                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }

    func add(_ entity: FruitEntity) {
        let furit: Fruit = repository.create()
        furit.name = entity.name
        repository.add(furit)
    }

    func delete(predicate: [NSPredicate]) {
        repository.fetch(conditions: [.predicates(predicate)]) { result in
            switch result {
            case let .success(response):
                response.forEach {
                    repository.delete($0)
                }

            case let .failure(error):
                Logger.error(message: error.localizedDescription)
            }
        }
    }
}
