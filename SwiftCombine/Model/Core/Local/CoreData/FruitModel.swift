import Combine

struct FruitModel: Model {
    func fetch() -> AnyPublisher<[FruitEntity], Never> {
        toPublisher { promise in
            let entity = FruitCoreDataHolder.all.map(FruitMapper().convert)
            promise(.success(entity))
        }
    }
}
