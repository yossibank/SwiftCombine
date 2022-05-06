import CoreData

extension Club {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Club> {
        return NSFetchRequest<Club>(entityName: "Club")
    }

    @NSManaged public var name: String
    @NSManaged public var money: Int32
    @NSManaged public var place: String?
    @NSManaged public var schedule: String?
    @NSManaged public var student: NSSet?

    var students: [Student] {
        student?.allObjects as? [Student] ?? []
    }
}

extension Club : Identifiable {}
