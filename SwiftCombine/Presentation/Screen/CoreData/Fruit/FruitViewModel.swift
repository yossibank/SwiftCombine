import Combine
import Foundation

// MARK: - properties & init

final class FruitViewModel: ViewModel {
    typealias State = LoadingState<[FruitEntity], CoreDataError>

    @Published var items: [FruitItem] = []
    @Published var addName: String = ""
    @Published var deleteName: String = ""
    @Published private(set) var state: State = .standby

    private var cancellables: Set<AnyCancellable> = .init()

    private let usecase: FruitUsecase

    init(usecase: FruitUsecase = Domain.Usecase.CoreData.Fruit()) {
        self.usecase = usecase
    }
}

// MARK: - internal methods

extension FruitViewModel {
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
            self?.items = state.map { .init(title: $0.name) }
            self?.state = .done(state)
        }
        .store(in: &cancellables)
    }

    func add() {
        usecase.add(.init(name: addName))
    }

    func delete() {
        let predicate = [NSPredicate(format: "%K = %@", "name", deleteName)]
        usecase.delete(predicate: predicate)
    }
}
