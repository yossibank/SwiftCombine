import Combine

extension ModelImpl where R == Repos.Joke {
    func fetch() -> AnyPublisher<JokeResponse, APIError> {
        toPublisher { promise in
            repository.request(
                useTestData: useTestData,
                parameters: .init(),
                pathComponent: .init()
            ) { result in
                switch result {
                case let .success(response):
                    promise(.success(response))

                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }
}
