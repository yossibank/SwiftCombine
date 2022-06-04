import Combine

struct JokeModel: Model {
    private let jokeId: String
    private let useTestData: Bool

    init(jokeId: String, useTestData: Bool = false) {
        self.jokeId = jokeId
        self.useTestData = useTestData
    }

    func fetch() -> AnyPublisher<JokeEntity, APIError> {
        toPublisher { promise in
            APIClient().request(
                item: JokeRequest(
                    parameters: .init(),
                    pathComponent: jokeId
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
