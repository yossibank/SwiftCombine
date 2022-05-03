import CoreData

protocol CoreDataRepo {
    associatedtype T: NSManagedObject

    func fetch(predicate: NSPredicate?, completion: @escaping (Result<[T], CoreDataError>) -> Void)
    func create<T: NSManagedObject>() -> T
    func add(_ object: T)
    func delete(_ object: T)
}

struct CoreDataRepository<T: NSManagedObject>: CoreDataRepo {
    private var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        return managedObjectModel
    }()

    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    private let persistentContainer: NSPersistentContainer
    private let useTestData: Bool

    init(useTestData: Bool) {
        self.useTestData = useTestData

        let container = NSPersistentContainer(name: "Model", managedObjectModel: managedObjectModel)

        if useTestData {
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

        self.persistentContainer = container
    }

    func fetch(
        predicate: NSPredicate? = nil,
        completion: @escaping (Result<[T], CoreDataError>) -> Void
    ) {
        do {
            let request = NSFetchRequest<T>(entityName: String(describing: T.self))
            request.predicate = predicate
            let entity = try context.fetch(request)
            completion(.success(entity))
        } catch {
            completion(.failure(.failed(error.localizedDescription)))
        }
    }

    func create<T: NSManagedObject>() -> T {
        let entity = NSEntityDescription.entity(
            forEntityName: String(describing: T.self),
            in: context
        )!

        return T(entity: entity, insertInto: context)
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
    private func save() {
        guard context.hasChanges else {
            return
        }

        do {
            try context.save()
        } catch {
            Logger.error(message: error.localizedDescription)
        }
    }

    private func rollback() {
        guard context.hasChanges else {
            return
        }

        context.rollback()
    }
}
