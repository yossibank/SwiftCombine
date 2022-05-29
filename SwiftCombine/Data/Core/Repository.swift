import CoreData

protocol Repository {
    associatedtype T: Request

    func request(
        useTestData: Bool,
        parameters: T.Parameters,
        pathComponent: T.PathComponent,
        completion: @escaping (Result<T.Response, APIError>) -> Void
    )

    func request(
        parameters: T.Parameters,
        pathComponent: T.PathComponent
    ) -> T.Response?
}

protocol CoreDataRepository {
    associatedtype T: NSManagedObject

    func fetch(conditions: [SearchCondition], completion: @escaping (Result<[T], CoreDataError>) -> Void)
    func object() -> T
    func add(_ object: T)
    func delete(_ object: T)
}

struct RepositoryImpl<T> {}

extension RepositoryImpl: Repository where T: Request {
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

    @discardableResult
    func request(
        parameters: T.Parameters,
        pathComponent: T.PathComponent
    ) -> T.Response? {
        let item = T(
            parameters: parameters,
            pathComponent: pathComponent
        )

        return item.localDataInterceptor(parameters)
    }
}

extension RepositoryImpl where T: Request, T.Parameters == EmptyParameters {
    func request(
        useTestData: Bool,
        pathComponent: T.PathComponent,
        completion: @escaping (Result<T.Response, APIError>) -> Void
    ) {
        request(
            useTestData: useTestData,
            parameters: .init(),
            pathComponent: pathComponent,
            completion: completion
        )
    }

    @discardableResult
    func request(
        pathComponent: T.PathComponent
    ) -> T.Response? {
        let item = T(
            parameters: .init(),
            pathComponent: pathComponent
        )

        return item.localDataInterceptor(.init())
    }
}

extension RepositoryImpl where T: Request, T.PathComponent == EmptyPathComponent {
    func request(
        useTestData: Bool,
        parameters: T.Parameters,
        completion: @escaping (Result<T.Response, APIError>) -> Void
    ) {
        request(
            useTestData: useTestData,
            parameters: parameters,
            pathComponent: .init(),
            completion: completion
        )
    }

    @discardableResult
    func request(
        parameters: T.Parameters
    ) -> T.Response? {
        let item = T(
            parameters: parameters,
            pathComponent: .init()
        )

        return item.localDataInterceptor(parameters)
    }
}

extension RepositoryImpl where T: Request, T.Parameters == EmptyParameters, T.PathComponent == EmptyPathComponent {
    func request(
        useTestData: Bool,
        completion: @escaping (Result<T.Response, APIError>) -> Void
    ) {
        request(
            useTestData: useTestData,
            parameters: .init(),
            pathComponent: .init(),
            completion: completion
        )
    }

    @discardableResult
    func request() -> T.Response? {
        let item = T(
            parameters: .init(),
            pathComponent: .init()
        )

        return item.localDataInterceptor(.init())
    }
}

extension RepositoryImpl: CoreDataRepository where T: NSManagedObject {
    func fetch(
        conditions: [SearchCondition] = [],
        completion: @escaping (Result<[T], CoreDataError>) -> Void
    ) {
        do {
            let request = NSFetchRequest<T>(entityName: String(describing: T.self))

            conditions.forEach { condition in
                switch condition {
                case let .predicates(contents):
                    request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: contents)

                case let .sort(content):
                    request.sortDescriptors = [content]
                }
            }

            let entity = try CoreDataManager.shared.context.fetch(request)
            completion(.success(entity))
        } catch {
            completion(.failure(.failed(error.localizedDescription)))
        }
    }

    func object() -> T {
        let entity = NSEntityDescription.entity(
            forEntityName: String(describing: T.self),
            in: CoreDataManager.shared.context
        )!

        return T(entity: entity, insertInto: CoreDataManager.shared.context)
    }

    func add(_ object: T) {
        CoreDataManager.shared.context.insert(object)
        save()
    }

    func delete(_ object: T) {
        CoreDataManager.shared.context.delete(object)
        save()
    }

    private func save() {
        guard CoreDataManager.shared.context.hasChanges else {
            return
        }

        do {
            try CoreDataManager.shared.context.save()
        } catch {
            Logger.error(message: error.localizedDescription)
        }
    }
}
