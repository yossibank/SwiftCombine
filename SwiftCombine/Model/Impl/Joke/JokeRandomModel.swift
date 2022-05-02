import Combine

extension ModelImpl where R == Repos.Joke.Random, M == JokeRandomMapper {
    func fetch() -> AnyPublisher<JokeRandomEntity, APIError> {
        toPublisher { promise in
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
