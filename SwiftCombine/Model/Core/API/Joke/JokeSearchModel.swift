import Combine

struct JokeSearchModel: Model, APIRequestable {
    typealias T = JokeSearchRequest

    private let useTestData: Bool

    init(useTestData: Bool = false) {
        self.useTestData = useTestData
    }

    func fetch(parameters: T.Parameters) -> AnyPublisher<JokeSearchEntity, APIError> {
        toPublisher { promise in
            request(
                useTestData: useTestData,
                parameters: .init(page: parameters.page, limit: parameters.limit, term: parameters.term),
                pathComponent: .init()
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
