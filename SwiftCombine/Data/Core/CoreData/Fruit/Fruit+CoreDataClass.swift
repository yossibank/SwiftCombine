import CoreData

@objc(Fruit)
public class Fruit: NSManagedObject {
    func configure(_ entity: FruitEntity) {
        name = entity.name
    }
}
