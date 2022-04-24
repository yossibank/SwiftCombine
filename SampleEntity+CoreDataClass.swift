import CoreData

@objc(SampleEntity)
public class SampleEntity: NSManagedObject {
    static func new(data: SampleEntity) -> SampleEntity {
        let entity: SampleEntity = CoreDataRepository.entity()
        entity.name = data.name
        entity.age = data.age
        return entity
    }

    func update(data: SampleEntity) {
        self.name = data.name
        self.age = data.age
    }
}
