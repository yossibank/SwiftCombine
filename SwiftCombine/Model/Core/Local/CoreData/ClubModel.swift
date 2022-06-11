import Combine

struct ClubModel: Model {
    func fetch() -> AnyPublisher<[ClubEntity], Never> {
        toPublisher { promise in
            let entity = ClubCoreDataHolder.all.map(ClubMapper().convert)
            promise(.success(entity))
        }
    }
}
