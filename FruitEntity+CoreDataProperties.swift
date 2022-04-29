import CoreData

extension FruitEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FruitEntity> {
        return NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
    }

    @NSManaged public var name: String?
}

extension FruitEntity : Identifiable {}
