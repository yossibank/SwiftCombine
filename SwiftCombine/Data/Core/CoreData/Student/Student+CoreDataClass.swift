import CoreData

@objc(Student)
public class Student: NSManagedObject {
    public convenience init(name: String, age: Int, number: Int) {
        let context = CoreDataManager.shared.context

        self.init(context: context)
        self.name = name
        self.age = Int32(age)
        self.number = Int32(number)
    }

    static func find(name: String) -> Student? {
        CoreDataHolder.students.filter({ $0.name == name }).first
    }

    static func create(entity: StudentEntity) -> Student {
        if let student = find(name: entity.name) {
            student.age = Int32(entity.age)
            student.number = Int32(entity.number)
            return student
        } else {
            return .init(
                name: entity.name,
                age: entity.age,
                number: entity.number
            )
        }
    }
}
