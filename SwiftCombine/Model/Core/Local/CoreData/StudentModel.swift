import Combine

struct StudentModel: Model {
    func fetch() -> AnyPublisher<[StudentEntity], Never> {
        toPublisher { promise in
            let entity = CoreDataHolder.students.map(StudentMapper().convert)
            promise(.success(entity))
        }
    }
}
