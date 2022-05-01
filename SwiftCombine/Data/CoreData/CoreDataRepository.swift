import CoreData

protocol CoreDataRepo {
    associatedtype T: NSManagedObject

    func fetchAll(completion: @escaping (Result<[T], CoreDataError>) -> Void)
    func entity<T: NSManagedObject>() -> T
    func add(_ object: T)
    func delete(_ object: T)
}

struct CoreDataRepository<T: NSManagedObject>: CoreDataRepo {
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let error = error {
                Logger.error(message: error.localizedDescription)
            }
        }
        return container
    }()

    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func fetchAll(completion: @escaping (Result<[T], CoreDataError>) -> Void) {
        do {
            let request = NSFetchRequest<T>(entityName: String(describing: T.self))
            let entity = try context.fetch(request)
            completion(.success(entity))
        } catch {
            completion(.failure(.failed(error.localizedDescription)))
        }
    }

    func entity<T: NSManagedObject>() -> T {
        let entity = NSEntityDescription.entity(
            forEntityName: String(describing: T.self),
            in: context
        )!

        return T(entity: entity, insertInto: nil)
    }

    func add(_ object: T) {
        context.insert(object)
        save()
    }

    func delete(_ object: T) {
        context.delete(object)
        save()
    }
}

extension CoreDataRepository {
    func save() {
        guard context.hasChanges else {
            return
        }

        do {
            try context.save()
        } catch {
            Logger.error(message: error.localizedDescription)
        }
    }

    func rollback() {
        guard context.hasChanges else {
            return
        }

        context.rollback()
    }
}
