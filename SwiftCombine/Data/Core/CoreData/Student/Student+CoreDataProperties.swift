import CoreData

extension Student {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String
    @NSManaged public var age: Int32
    @NSManaged public var number: Int32
    @NSManaged public var club: Club?
}

extension Student : Identifiable {}
