import Combine

final class JokeRandomViewModel: ViewModel {
    typealias State = LoadingState<JokeEntity, APIError>

    @Published private(set) var state: State = .standby

    private let model: JokeRandomModel

    private var cancellables: Set<AnyCancellable> = .init()

    init(model: JokeRandomModel = Model.Joke.Random()) {
        self.model = model
    }
}

// MARK: - internal methods

extension JokeRandomViewModel {
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
