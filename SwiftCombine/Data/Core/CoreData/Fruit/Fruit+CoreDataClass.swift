import CoreData

@objc(Fruit)
public class Fruit: NSManagedObject {
    public convenience init(name: String) {
        self.init(context: CoreDataManager.shared.context)
        self.name = name
    }
}
