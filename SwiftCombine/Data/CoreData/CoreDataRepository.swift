import CoreData

final class CoreDataRepository {
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    private static var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}

// MARK: - Create

extension CoreDataRepository {
    static func entity<T: NSManagedObject>() -> T {
        let entity = NSEntityDescription.entity(
            forEntityName: String(describing: T.self),
            in: context
        )!

        return T(entity: entity, insertInto: nil)
    }
}

// MARK: - CRUD

extension CoreDataRepository {
    static func array<T: NSManagedObject>() -> [T] {
        do {
            let request = NSFetchRequest<T>(entityName: String(describing: T.self))
            return try context.fetch(request)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    static func add(_ object: NSManagedObject) {
        context.insert(object)
    }

    static func delete(_ object: NSManagedObject) {
        context.delete(object)
    }
}

// MARK: - context CRUD

extension CoreDataRepository {
    static func save() {
        guard context.hasChanges else {
            return
        }

        do {
            try context.save()
        } catch let error as NSError {
            debugPrint("Error: \(error), \(error.userInfo)")
        }
    }

    static func rollback() {
        guard context.hasChanges else {
            return
        }

        context.rollback()
    }
}
