import CoreData

struct CoreDataStorage<T: NSManagedObject> {
    private static var context: NSManagedObjectContext {
        CoreDataManager.shared.context
    }

    static func fetch(
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

            let entity = try context.fetch(request)
            completion(.success(entity))
        } catch {
            completion(.failure(.failed(error.localizedDescription)))
        }
    }

    static func object() -> T {
        let entity = NSEntityDescription.entity(
            forEntityName: String(describing: T.self),
            in: context
        )!

        return T(entity: entity, insertInto: context)
    }

    static func add(_ object: T) {
        context.insert(object)
        save()
    }

    static func delete(_ object: T) {
        context.delete(object)
        save()
    }

    private static func save() {
        guard context.hasChanges else {
            return
        }

        do {
            try context.save()
        } catch {
            Logger.error(message: error.localizedDescription)
        }
    }
}
