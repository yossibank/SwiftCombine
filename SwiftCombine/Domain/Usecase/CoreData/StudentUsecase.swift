import Combine

extension UsecaseImpl where R == Repos.Local.Student, M == StudentMapper {
    func fetch() -> AnyPublisher<[StudentEntity], Never> {
        toPublisher { promise in
            guard let response = resource.request() else {
                return
            }

            let entity = response.map(mapper.convert)
            promise(.success(entity))
        }
    }
}
