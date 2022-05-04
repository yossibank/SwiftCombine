import CoreData
import Combine

final class FruitViewModel: ViewModel {
    typealias State = LoadingState<[FruitEntity], CoreDataError>

    @Published var items: [FruitItem] = []
    @Published var addName: String = ""
    @Published var deleteName: String = ""
    @Published private(set) var state: State = .standby

    private var cancellables: Set<AnyCancellable> = .init()

    private let model: FruitModel

    init(model: FruitModel = Model.CoreData.Fruit()) {
        self.model = model
    }
}

// MARK: - internal methods

extension FruitViewModel {
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
            self?.items = state.map { .init(title: $0.name) }
            self?.state = .done(state)
        }
        .store(in: &cancellables)
    }

    func add() {
        model.add(.init(name: addName))
    }

    func delete() {
        let predicate = NSPredicate(format: "%K=%@", "name", deleteName)
        model.delete(predicate: predicate)
    }
}
