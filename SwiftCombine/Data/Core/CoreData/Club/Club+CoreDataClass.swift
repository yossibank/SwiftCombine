import CoreData

@objc(Club)
public class Club: NSManagedObject {
    func configure(_ entity: ClubEntity) {
        name = entity.name
        money = Int32(entity.money)
        place = entity.place
        schedule = entity.schedule
    }
}
