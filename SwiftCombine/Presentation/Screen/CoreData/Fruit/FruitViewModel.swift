import Combine
import Foundation

// MARK: - properties & init

final class FruitViewModel: ViewModel {
    typealias State = LoadingState<[FruitEntity], Never>

    @Published var items: [FruitItem] = []
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

        usecase.fetch().sink { completion in
            switch completion {
            case .finished:
                Logger.debug(message: "finished")

            default:
                break
            }
        } receiveValue: { [weak self] state in
            self?.items = state.map { .init(title: $0.name) }
            self?.state = .done(state)
        }
        .store(in: &cancellables)
    }
}
