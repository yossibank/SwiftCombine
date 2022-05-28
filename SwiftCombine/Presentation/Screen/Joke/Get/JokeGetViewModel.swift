import Combine

// MARK: - properties & init

final class JokeGetViewModel: ViewModel {
    typealias State = LoadingState<JokeEntity, APIError>

    @Published private(set) var state: State = .standby

    private var cancellables: Set<AnyCancellable> = .init()

    private let usecase: JokeUsecase
    private let jokeId: String

    init(
        usecase: JokeUsecase = Domain.Usecase.Joke.Get(),
        jokeId: String
    ) {
        self.usecase = usecase
        self.jokeId = jokeId
    }
}

// MARK: - internal methods

extension JokeGetViewModel {
    func fetch() {
        state = .loading

        usecase.fetch(jokeId: jokeId).sink { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.state = .failed(error)
                Logger.debug(message: error.localizedDescription)

            case .finished:
                Logger.debug(message: "finished")
            }
        } receiveValue: { [weak self] state in
            self?.state = .done(state)
        }
        .store(in: &cancellables)
    }
}
