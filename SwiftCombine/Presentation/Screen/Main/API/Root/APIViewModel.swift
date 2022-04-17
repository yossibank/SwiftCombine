import Combine

final class APIViewModel: ViewModel {
    typealias State = LoadingState<JokeResponse, APIError>

    @Published private(set) var state: State = .standby

    private let model: JokeModel

    private var cancellables: Set<AnyCancellable> = .init()

    init(model: JokeModel = Model.Joke()) {
        self.model = model
    }
}

// MARK: - internal methods

extension APIViewModel {

    func fetch() {
        state = .loading

        model.fetch().sink { [weak self] completion in
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
