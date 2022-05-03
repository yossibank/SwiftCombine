import Combine

final class JokeGetViewModel: ViewModel {
    typealias State = LoadingState<JokeEntity, APIError>

    @Published private(set) var state: State = .standby

    private let model: JokeGetModel

    private var cancellables: Set<AnyCancellable> = .init()

    init(model: JokeGetModel = Model.Joke.Get()) {
        self.model = model
    }
}

// MARK: - internal methods

extension JokeGetViewModel {
    func fetch() {
        state = .loading

        model.fetch(jokeId: AppDataHolder.jokeId).sink { [weak self] completion in
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
