import CoreData

@objc(Fruit)
public class Fruit: NSManagedObject {
    public convenience init(name: String) {
        let context = CoreDataManager.shared.context

        self.init(context: context)
        self.name = name
    }

    static func create(name: String) -> Fruit {
        if let fruit = CoreDataHolder.fruits.filter({ $0.name == name }).first {
            fruit.name = name
            return fruit
        } else {
            return .init(name: name)
        }
    }
}
