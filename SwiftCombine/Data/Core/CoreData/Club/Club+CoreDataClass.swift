import CoreData

@objc(Club)
public class Club: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case name
        case money
        case place
        case schedule
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.money = try container.decode(Int32.self, forKey: .money)
        self.place = try container.decode(String.self, forKey: .place)
        self.schedule = try container.decode(String.self, forKey: .schedule)
    }
}
