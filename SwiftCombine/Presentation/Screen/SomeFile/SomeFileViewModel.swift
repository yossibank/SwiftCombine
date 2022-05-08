import Combine

// MARK: - properties & init

final class SomeFileViewModel: ViewModel {
    @Published var text1: String = ""
    @Published var text2: String = ""
    @Published var text3: String = ""
    @Published var someFile: [String] = []

    private var cancellables: Set<AnyCancellable> = .init()

    private let getModel: GetSomeFileModel
    private let setModel: SetSomeFileModel

    init(
        getModel: GetSomeFileModel = Model.SomeFile.Get(),
        setModel: SetSomeFileModel = Model.SomeFile.Set()
    ) {
        self.getModel = getModel
        self.setModel = setModel
    }
}

// MARK: - internal methods

extension SomeFileViewModel {
    func fetch() {
        getModel.fetch().sink { [weak self] value in
            guard let self = self else { return }
            Logger.debug(message: "FileManager SomeFile: \(value)")
            self.someFile = value
        }
        .store(in: &cancellables)
    }

    func set() {
        var someFile: [String] = []

        [text1, text2, text3].forEach {
            if !$0.isEmpty {
                someFile.append($0)
            }
        }

        setModel.set(someFile)
            .sink { _ in }
            .store(in: &cancellables)
    }
}
