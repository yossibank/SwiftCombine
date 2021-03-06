import Combine

extension UsecaseImpl where R == Repos.Joke.Get, M == JokeMapper {
    func fetch(jokeId: String) -> AnyPublisher<JokeEntity, APIError> {
        toPublisher { promise in
            analytics.sendEvent()

            resource.request(
                useTestData: useTestData,
                parameters: .init(),
                pathComponent: jokeId
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
