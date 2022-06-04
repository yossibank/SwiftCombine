import Combine

struct JokeSlackModel: Model, APIRequestable {
    typealias T = JokeSlackRequest

    private let useTestData: Bool

    init(useTestData: Bool = false) {
        self.useTestData = useTestData
    }

    func fetch() -> AnyPublisher<JokeSlackEntity, APIError> {
        toPublisher { promise in
            request(
                useTestData: useTestData,
                parameters: .init(),
                pathComponent: .init()
            ) { result in
                switch result {
                case let .success(response):
                    let entity = JokeSlackMapper().convert(response: response)
                    promise(.success(entity))

                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }
}
