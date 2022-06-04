import Combine

// MARK: - properties & init

final class JokeSearchViewModel: ViewModel {
    typealias State = LoadingState<JokeSearchEntity, APIError>

    @Published var items: [JokeSearchItem] = []
    @Published private(set) var state: State = .standby

    private var nextPage: Int = 1
    private var previousPage: Int = 1
    private var totalPages: Int = 1
    private var cancellables: Set<AnyCancellable> = .init()

    private let model: JokeSearchModel

    init(model: JokeSearchModel = JokeSearchModel()) {
        self.model = model
    }
}

// MARK: - internal methods

extension JokeSearchViewModel {
    func fetch(isAdditional: Bool) {
        guard totalPages - previousPage != 1 else {
            return
        }

        state = .loading

        model.fetch(parameters: .init(page: nextPage)).sink { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.state = .failed(error)
                Logger.debug(message: error.localizedDescription)

            case .finished:
                Logger.debug(message: "finished")
            }
        } receiveValue: { [weak self] state in
            self?.nextPage = state.nextPage
            self?.previousPage = state.previousPage
            self?.totalPages = state.totalPages

            let items = state.results.map { JokeSearchItem(id: $0.id, joke: $0.joke) }

            if isAdditional {
                self?.items.append(contentsOf: items)
            } else {
                self?.items = items
            }

            self?.state = .done(state)
        }
        .store(in: &cancellables)
    }
}
