import Combine
import Foundation

// MARK: - properties & init

final class StudentViewModel: ViewModel {
    typealias State = LoadingState<[StudentEntity], Never>

    @Published var items: [StudentItem] = []
    @Published private(set) var state: State = .standby

    private var cancellables: Set<AnyCancellable> = .init()

    private let model: StudentModel

    init(model: StudentModel = StudentModel()) {
        self.model = model
    }
}

// MARK: - internal methods

extension StudentViewModel {
    func fetch() {
        state = .loading

        model.fetch().sink { completion in
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
