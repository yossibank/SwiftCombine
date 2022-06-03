import CoreData

@objc(Student)
public class Student: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case name
        case age
        case number
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int32.self, forKey: .age)
        self.number = try container.decode(Int32.self, forKey: .number)
    }
}
