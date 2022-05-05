import Combine
import Foundation

// MARK: - properties & init

final class StudentViewModel: ViewModel {
    typealias State = LoadingState<[StudentEntity], CoreDataError>

    var isEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3($name, $age, $number)
            .map { name, age, number in
                !name.isEmpty && !age.isEmpty && !number.isEmpty
            }
            .eraseToAnyPublisher()
    }

    @Published var items: [StudentItem] = []
    @Published var name: String = ""
    @Published var age: String = ""
    @Published var number: String = ""
    @Published private(set) var state: State = .standby

    private var cancellables: Set<AnyCancellable> = .init()

    private let model: StudentModel

    init(model: StudentModel = Model.CoreData.Student()) {
        self.model = model
    }
}

// MARK: - internal methods

extension StudentViewModel {
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
            self?.items = state.map { .init(name: $0.name, age: $0.age, number: $0.number) }
            self?.state = .done(state)
        }
        .store(in: &cancellables)
    }

    func add() {
        model.add(.init(
            name: name,
            age: Int(age) ?? 0,
            number: Int(number) ?? 0
        ))
    }

    func delete(name: String) {
        let predicate = [NSPredicate(format: "%K = %@", "name", name)]
        model.delete(predicate: predicate)
    }
}
