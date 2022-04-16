import Combine

protocol ModelProtocol {
    associatedtype Repository

    var repository: Repository { get }
    var useTestData: Bool { get }
}

struct ModelImpl<R>: ModelProtocol {
    var repository: R
    var useTestData: Bool = false

    func toPublisher<T: Equatable, E: Error>(
        closure: @escaping (@escaping Future<T, E>.Promise) -> Void
    ) -> AnyPublisher<T, E> {
        Deferred {
            Future { promise in
                closure(promise)
            }
        }.eraseToAnyPublisher()
    }
}
