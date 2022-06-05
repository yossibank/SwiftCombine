import CoreData

@propertyWrapper
final class FetchCoreData<T: NSManagedObject> {
    private let sortDescriptors: [NSSortDescriptor]
    private var predicate: NSPredicate?
    private let fetchLimit: Int

    init(
        sortDescriptors: [NSSortDescriptor] = [],
        predicate: NSPredicate? = nil,
        fetchLimit: Int = 0
    ) {
        self.sortDescriptors = sortDescriptors
        self.predicate = predicate
        self.fetchLimit = fetchLimit
    }

    var projectedValue: NSPredicate? {
        get {
            predicate
        }
        set {
            self.predicate = newValue
        }
    }

    var wrappedValue: [T] {
        CoreDataStorage.fetch(
            sortDescriptors: sortDescriptors,
            predicate: predicate,
            fetchLimit: fetchLimit
        )
    }
}

struct CoreDataStorage<T: NSManagedObject> {
    static var context: NSManagedObjectContext {
        CoreDataManager.shared.context
    }

    static func fetch(
        sortDescriptors: [NSSortDescriptor] = [],
        predicate: NSPredicate? = nil,
        fetchLimit: Int = 0
    ) -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = fetchLimit

        guard let result = try? context.fetch(fetchRequest) else {
            return []
        }

        return result
    }

    static func insert(_ object: T) {
        try? context.obtainPermanentIDs(for: [object])
        context.saveIfNeeded()
    }

    static func delete(_ object: T) {
        context.delete(object)
        context.saveIfNeeded()
    }
}
