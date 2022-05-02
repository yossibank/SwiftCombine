import CoreData

extension Fruit {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fruit> {
        return NSFetchRequest<Fruit>(entityName: "Fruit")
    }

    @NSManaged public var name: String
}

extension Fruit : Identifiable {}
