import CoreData

@objc(Club)
public class Club: NSManagedObject {
    public convenience init(name: String, money: Int, place: String?, schedule: String?) {
        let context = CoreDataManager.shared.context

        self.init(context: context)
        self.name = name
        self.money = Int32(money)
        self.place = place
        self.schedule = schedule
    }

    static func find(name: String) -> Club? {
        CoreDataHolder.clubs.filter { $0.name == name }.first
    }

    static func create(entity: ClubEntity) -> Club {
        if let club = find(name: entity.name) {
            club.money = Int32(entity.money)
            club.place = entity.place
            club.schedule = entity.schedule
            return club
        } else {
            return .init(
                name: entity.name,
                money: entity.money,
                place: entity.place,
                schedule: entity.schedule
            )
        }
    }
}
