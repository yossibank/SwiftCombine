import Combine

// MARK: - properties & init

final class ClubViewModel: ViewModel {
    typealias State = LoadingState<[ClubEntity], Never>

    @Published var items: [ClubItem] = []
    @Published private(set) var state: State = .standby

    private var cancellables: Set<AnyCancellable> = .init()

    private let usecase: ClubUsecase

    init(usecase: ClubUsecase = Domain.Usecase.CoreData.Club()) {
        self.usecase = usecase
    }
}

// MARK: - internal methods

extension ClubViewModel {
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
            self?.items = state.map {
                .init(
                    name: $0.name,
                    money: $0.money,
                    place: $0.place ?? "",
                    schedule: $0.schedule ?? "",
                    students: $0.students.map { .init(name: $0.name) }
                )
            }
            self?.state = .done(state)
        }
        .store(in: &cancellables)
    }
}
