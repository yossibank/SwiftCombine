import CoreData

final class CoreDataManager {
    private(set) lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()

    private lazy var persistentContainer: NSPersistentContainer = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let container = NSPersistentContainer(name: "Model", managedObjectModel: managedObjectModel)

        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
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

    /// テスト用
    func deleteObject<T: NSManagedObject>(_ object: T) {
        let result = NSFetchRequest<T>(entityName: String(describing: T.self))

        do {
            let entity = try context.fetch(result)
            entity.forEach { context.delete($0) }
        } catch {
            Logger.error(message: error.localizedDescription)
        }
    }
}
