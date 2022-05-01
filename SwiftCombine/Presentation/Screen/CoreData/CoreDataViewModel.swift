import CoreData
import Combine

final class CoreDataViewModel: ViewModel {
    typealias State = LoadingState<[FruitEntity], CoreDataError>

    @Published var name: String = ""
    @Published var items: [CoreDataItem] = []
    @Published private(set) var state: State = .standby

    private let model: FruitModel

    private var cancellables: Set<AnyCancellable> = .init()

    init(model: FruitModel = Model.CoreData.Fruit()) {
        self.model = model
    }
}

// MARK: - internal methods

extension CoreDataViewModel {
    func fetchAll() {
        state = .loading

        model.fetchAll().sink { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.state = .failed(error)
                Logger.debug(message: error.localizedDescription)

            case .finished:
                Logger.debug(message: "finished")
            }
        } receiveValue: { [weak self] state in
            self?.items = state.map { .init(title: $0.name ?? "") }
            self?.state = .done(state)
        }
        .store(in: &cancellables)
    }

    func add() {
        model.add(fruitName: name)
    }
}
