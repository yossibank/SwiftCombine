import Combine

struct SomeFileModel: Model {
    func fetch() -> AnyPublisher<[String], Never> {
        toPublisher { promise in
            promise(.success(PersistedDataHolder.someFile ?? []))
        }
    }

    func set(someFile: [String]) {
        PersistedDataHolder.someFile = someFile
    }
}
