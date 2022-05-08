import Combine

protocol ModelProtocol {
    associatedtype Repository
    associatedtype Mapper

    var repository: Repository { get }
    var mapper: Mapper { get }
    var analytics: Analytics { get }
}

struct ModelImpl<R, M>: ModelProtocol {
    var repository: R
    var mapper: M
    var analytics: Analytics = .shared
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
