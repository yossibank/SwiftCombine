struct GetStudentRequest: LocalRequest {
    typealias Response = [Student]
    typealias Parameters = EmptyParameters
    typealias PathComponent = EmptyPathComponent

    var localDataInterceptor: (Parameters) -> Response? {
        { _ in
            CoreDataHolder.students
        }
    }

    init(parameters: Parameters, pathComponent: PathComponent) {}
}
