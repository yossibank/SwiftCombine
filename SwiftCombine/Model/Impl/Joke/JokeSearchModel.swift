import Combine

extension ModelImpl where R == Repos.Joke.Search, M == JokeSearchMapper {
    func fetch(parameters: JokeSearchRequest.Parameters) -> AnyPublisher<JokeSearchEntity, APIError> {
        toPublisher { promise in
            repository.request(
                useTestData: useTestData,
                parameters: parameters,
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
