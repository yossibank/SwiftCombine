import CoreData

final class CoreDataManager {
    private(set) lazy var context = persistentContainer.viewContext

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
                    try context.execute(batchDeleteRequest)
                } catch {
                    Logger.error(message: error.localizedDescription)
                }
            }

        context.reset()
    }
}

extension NSManagedObjectContext {
    func saveIfNeeded() {
        if !hasChanges {
            Logger.info(message: "contextに対して変更処理が入っていません")
            return
        }

        do {
            try save()
        } catch {
            Logger.error(message: error.localizedDescription)
        }
    }
}
