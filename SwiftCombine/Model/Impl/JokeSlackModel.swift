import Combine

extension ModelImpl where R == Repos.JokeSlack {
    func fetch() -> AnyPublisher<JokeSlackResponse, APIError> {
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
