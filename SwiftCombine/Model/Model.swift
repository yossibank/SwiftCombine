import Combine

protocol Model {
    func toPublisher<T: Equatable, E: Error>(
        closure: @escaping (@escaping Future<T, E>.Promise) -> Void
    ) -> AnyPublisher<T, E>
}

extension Model {
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

protocol APIRequestable {
    associatedtype T: Request

    func request(
        useTestData: Bool,
        parameters: T.Parameters,
        pathComponent: T.PathComponent,
        completion: @escaping (Result<T.Response, APIError>) -> Void
    )
}

extension APIRequestable {
    func request(
        useTestData: Bool,
        parameters: T.Parameters,
        pathComponent: T.PathComponent,
        completion: @escaping (Result<T.Response, APIError>) -> Void
    ) {
        let item = T(
            parameters: parameters,
            pathComponent: pathComponent
        )

        APIClient().request(item: item, useTestData: useTestData) { result in
            switch result {
            case let .success(value):
                item.successHandler(value)

            case let .failure(error):
                item.failureHandler(error)
            }
            completion(result)
        }
    }
}
