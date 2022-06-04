import Combine
import Foundation

// MARK: - properties & init

final class StudentViewModel: ViewModel {
    typealias State = LoadingState<[StudentEntity], Never>

    @Published var items: [StudentItem] = []
    @Published private(set) var state: State = .standby

    private var cancellables: Set<AnyCancellable> = .init()

    private let usecase: StudentUsecase

    init(usecase: StudentUsecase = Domain.Usecase.CoreData.Student()) {
        self.usecase = usecase
    }
}

// MARK: - internal methods

extension StudentViewModel {
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
                    age: $0.age,
                    number: $0.number,
                    clubName: $0.club?.name
                )
            }
            self?.state = .done(state)
        }
        .store(in: &cancellables)
    }
}
