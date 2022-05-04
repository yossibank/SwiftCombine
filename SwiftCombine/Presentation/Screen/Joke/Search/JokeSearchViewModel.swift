import Combine

final class JokeSearchViewModel: ViewModel {
    typealias State = LoadingState<JokeSearchEntity, APIError>

    @Published var items: [JokeSearchItem] = []
    @Published private(set) var state: State = .standby

    private let model: JokeSearchModel

    private var cancellables: Set<AnyCancellable> = .init()

    init(model: JokeSearchModel = Model.Joke.Search()) {
        self.model = model
    }
}

// MARK: - internal methods

extension JokeSearchViewModel {
    func fetch() {
        state = .loading

        model.fetch(parameters: .init()).sink { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.state = .failed(error)
                Logger.debug(message: error.localizedDescription)

            case .finished:
                Logger.debug(message: "finished")
            }
        } receiveValue: { [weak self] state in
            self?.items = state.results.map { .init(id: $0.id, joke: $0.joke) }
            self?.state = .done(state)
        }
        .store(in: &cancellables)
    }
}
