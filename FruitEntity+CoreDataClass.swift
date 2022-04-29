import CoreData

@objc(FruitEntity)
public class FruitEntity: NSManagedObject {
    static func new(name: String) -> FruitEntity {
        let entity: FruitEntity = CoreDataRepository.entity()
        entity.name = name
        return entity
    }

    func update(name: String) {
        self.name = name
    }
}
