import Combine

struct JokeSlackModel: Model {
    private let useTestData: Bool

    init(useTestData: Bool = false) {
        self.useTestData = useTestData
    }

    func fetch() -> AnyPublisher<JokeSlackEntity, APIError> {
        toPublisher { promise in
            APIClient().request(
                item: JokeSlackRequest(
                    parameters: .init(),
                    pathComponent: .init()
                ),
                useTestData: useTestData
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
