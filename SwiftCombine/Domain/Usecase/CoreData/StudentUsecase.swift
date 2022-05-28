import Combine
import Foundation

extension UsecaseImpl where R == Repos.Local.StudentCoreData, M == StudentMapper {
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
        let object: Student = repository.object()
        object.configure(entity)
        repository.add(object)
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
