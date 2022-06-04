import Combine

struct FruitModel: Model {
    func fetch() -> AnyPublisher<[FruitEntity], Never> {
        toPublisher { promise in
            let entity = CoreDataHolder.fruits.map(FruitMapper().convert)
            promise(.success(entity))
        }
    }
}
