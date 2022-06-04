import CoreData

@objc(Fruit)
public class Fruit: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case name
    }

    public convenience init(name: String) {
        self.init(context: CoreDataManager.shared.context)
        self.name = name
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
