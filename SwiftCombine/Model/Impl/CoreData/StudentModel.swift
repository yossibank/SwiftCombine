import Combine
import Foundation

extension ModelImpl where R == Repos.Local.StudentCoreData, M == StudentMapper {
    func fetch() -> AnyPublisher<[StudentEntity], CoreDataError> {
        toPublisher { promise in
            repository.fetch() { result in
                switch result {
                case let .success(response):
                    let entities = response.map(mapper.convert)
                    promise(.success(entities))

                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }

    func add(_ entity: StudentEntity) {
        let student: Student = repository.create()
        student.name = entity.name
        student.age = Int32(entity.age)
        student.number = Int32(entity.number)
        repository.add(student)
    }

    func delete(predicate: [NSPredicate]) {
        repository.fetch(conditions: [.predicates(predicate)]) { result in
            switch result {
            case let .success(response):
                response.forEach {
                    repository.delete($0)
                }

            case let .failure(error):
                Logger.error(message: error.localizedDescription)
            }
        }
    }
}
