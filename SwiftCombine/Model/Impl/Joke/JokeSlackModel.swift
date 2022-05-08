import Combine

extension ModelImpl where R == Repos.Joke.Slack, M == JokeSlackMapper {
    func fetch() -> AnyPublisher<JokeSlackEntity, APIError> {
        toPublisher { promise in
            analytics.sendEvent()

            repository.request(
                useTestData: useTestData,
                parameters: .init(),
                pathComponent: .init()
            ) { result in
                switch result {
                case let .success(response):
                    let entity = mapper.convert(response: response)
                    promise(.success(entity))

                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }
}
