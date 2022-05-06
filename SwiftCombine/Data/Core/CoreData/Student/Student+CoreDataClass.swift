import CoreData

@objc(Student)
public class Student: NSManagedObject {
    func configure(_ entity: StudentEntity) {
        name = entity.name
        age = Int32(entity.age)
        number = Int32(entity.number)
    }
}
