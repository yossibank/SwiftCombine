import CoreData

extension SampleEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SampleEntity> {
        return NSFetchRequest<SampleEntity>(entityName: "SampleEntity")
    }

    @NSManaged public var age: Int64
    @NSManaged public var name: String?
}

extension SampleEntity : Identifiable {}
