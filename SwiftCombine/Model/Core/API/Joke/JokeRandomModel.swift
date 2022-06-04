import Combine

struct JokeRandomModel: Model {
    private let useTestData: Bool

    init(useTestData: Bool = false) {
        self.useTestData = useTestData
    }

    func fetch() -> AnyPublisher<JokeEntity, APIError> {
        toPublisher { promise in
            APIClient().request(
                item: JokeRandomRequest(
                    parameters: .init(),
                    pathComponent: .init()
                ),
                useTestData: useTestData
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
