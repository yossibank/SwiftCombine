import Combine

struct JokeRandomModel: Model, APIRequestable {
    typealias T = JokeRandomRequest

    private let useTestData: Bool

    init(useTestData: Bool = false) {
        self.useTestData = useTestData
    }

    func fetch() -> AnyPublisher<JokeEntity, APIError> {
        toPublisher { promise in
            request(
                useTestData: useTestData,
                parameters: .init(),
                pathComponent: .init()
            ) { result in
                switch result {
                case let .success(response):
                    let entity = JokeMapper().convert(response: response)
                    promise(.success(entity))

                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }
}
