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

    static func create(name: String, money: Int, place: String?, schedule: String?) -> Club {
        if let club = CoreDataHolder.clubs.filter({ $0.name == name }).first {
            club.money = Int32(money)
            club.place = place
            club.schedule = schedule
            return club
        } else {
            return .init(name: name, money: money, place: place, schedule: schedule)
        }
    }
}
