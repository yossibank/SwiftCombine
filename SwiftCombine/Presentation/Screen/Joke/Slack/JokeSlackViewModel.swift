import Combine

// MARK: - properties & init

final class JokeSlackViewModel: ViewModel {
    typealias State = LoadingState<JokeSlackEntity, APIError>

    @Published private(set) var state: State = .standby

    private var cancellables: Set<AnyCancellable> = .init()

    private let usecase: JokeSlackUsecase

    init(usecase: JokeSlackUsecase = Domain.Usecase.Joke.Slack()) {
        self.usecase = usecase
    }
}

// MARK: - internal methods

extension JokeSlackViewModel {
    func fetch() {
        state = .loading

        usecase.fetch().sink { [weak self] completion in
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
