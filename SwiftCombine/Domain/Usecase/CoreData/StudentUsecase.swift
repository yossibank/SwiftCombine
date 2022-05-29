import Combine
import Foundation

extension UsecaseImpl where R == Repos.Local.StudentCoreData, M == StudentMapper {
    func fetch() -> AnyPublisher<[StudentEntity], CoreDataError> {
        toPublisher { promise in
            resource.fetch() { result in
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
        let object = resource.object()
        object.configure(entity)
        resource.add(object)
    }

    func delete(predicate: [NSPredicate]) {
        resource.fetch(conditions: [.predicates(predicate)]) { result in
            switch result {
            case let .success(response):
                response.forEach {
                    resource.delete($0)
                }

            case let .failure(error):
                Logger.error(message: error.localizedDescription)
            }
        }
    }
}
