import Combine

struct JokeModel: Model, APIRequestable {
    typealias T = JokeRequest

    private let jokeId: String
    private let useTestData: Bool

    init(jokeId: String, useTestData: Bool = false) {
        self.jokeId = jokeId
        self.useTestData = useTestData
    }

    func fetch() -> AnyPublisher<JokeEntity, APIError> {
        toPublisher { promise in
            request(
                useTestData: useTestData,
                parameters: .init(),
                pathComponent: jokeId
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
