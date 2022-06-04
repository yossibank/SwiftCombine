import Combine

struct JokeSearchModel: Model {
    private let useTestData: Bool

    init(useTestData: Bool = false) {
        self.useTestData = useTestData
    }

    func fetch(parameters: JokeSearchRequest.Parameters) -> AnyPublisher<JokeSearchEntity, APIError> {
        toPublisher { promise in
            APIClient().request(
                item: JokeSearchRequest(
                    parameters: parameters,
                    pathComponent: .init()
                ),
                useTestData: useTestData
            ) { result in
                switch result {
                case let .success(response):
                    let entity = JokeSearchMapper().convert(response: response)
                    promise(.success(entity))

                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }
}
