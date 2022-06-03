import CoreData

final class CoreDataManager {
    private(set) lazy var viewContext = persistentContainer.viewContext

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")

        if AppConfig.isTesting {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            description.shouldAddStoreAsynchronously = false
            container.persistentStoreDescriptions = [description]
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                Logger.error(message: error.localizedDescription)
            }
        }

        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        container.viewContext.automaticallyMergesChangesFromParent = true

        return container
    }()

    static let shared = CoreDataManager()
    private init() {}
}

extension CoreDataManager {
    func deleteAllObject() {
        persistentContainer.managedObjectModel.entities
            .compactMap(\.name)
            .forEach {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: $0)
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

                do {
                    try viewContext.execute(batchDeleteRequest)
                } catch {
                    Logger.error(message: error.localizedDescription)
                }
            }

        viewContext.reset()
    }

    /// テスト用
    func deleteObject<T: NSManagedObject>(_ object: T) {
        let result = NSFetchRequest<T>(entityName: String(describing: T.self))

        do {
            let entity = try viewContext.fetch(result)
            entity.forEach { viewContext.delete($0) }
        } catch {
            Logger.error(message: error.localizedDescription)
        }
    }
}

extension NSManagedObjectContext {
    func saveIfNeeded() {
        if !hasChanges {
            return
        }

        do {
            try save()
        } catch {
            Logger.error(message: error.localizedDescription)
        }
    }
}
