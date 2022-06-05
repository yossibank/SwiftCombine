import CoreData

@objc(Fruit)
public class Fruit: NSManagedObject {
    public convenience init(name: String) {
        let context = CoreDataManager.shared.context

        self.init(context: context)
        self.name = name
    }

    static func find(name: String) -> Fruit? {
        CoreDataHolder.fruits.filter { $0.name == name }.first
    }

    static func create(name: String) -> Fruit {
        if let fruit = find(name: name) {
            fruit.name = name
            return fruit
        } else {
            return .init(name: name)
        }
    }
}
