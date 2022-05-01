import Combine

final class JokeSlackViewModel: ViewModel {
    typealias State = LoadingState<JokeSlackResponse, APIError>

    @Published private(set) var state: State = .standby

    private let model: JokeSlackModel

    private var cancellables: Set<AnyCancellable> = .init()

    init(model: JokeSlackModel = Model.JokeSlack()) {
        self.model = model
    }
}

// MARK: - internal methods

extension JokeSlackViewModel {
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
