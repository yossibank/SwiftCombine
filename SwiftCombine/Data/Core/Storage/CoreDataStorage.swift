import CoreData

@propertyWrapper
final class CoreDataStorage<T: NSManagedObject> {
    private let sortDescriptors: [NSSortDescriptor]
    private let predicate: NSPredicate?

    init(
        sortDescriptors: [NSSortDescriptor] = [],
        predicate: NSPredicate? = nil
    ) {
        self.sortDescriptors = sortDescriptors
        self.predicate = predicate
    }

    var wrappedValue: [T] {
        CoreDataStorageManager.fetch(sortDescriptors: sortDescriptors, predicate: predicate)
    }
}

private struct CoreDataStorageManager<T: NSManagedObject> {
    static func fetch(sortDescriptors: [NSSortDescriptor], predicate: NSPredicate?) -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate

        guard let result = try? CoreDataManager.shared.viewContext.fetch(fetchRequest) else {
            return []
        }

        return result
    }
}
