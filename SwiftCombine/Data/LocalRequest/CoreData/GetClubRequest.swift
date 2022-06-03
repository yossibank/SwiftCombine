struct GetClubRequest: LocalRequest {
    typealias Response = [Club]
    typealias Parameters = EmptyParameters
    typealias PathComponent = EmptyPathComponent

    var localDataInterceptor: (Parameters) -> Response? {
        { _ in
            CoreDataHolder.clubs
        }
    }

    init(parameters: Parameters, pathComponent: PathComponent) {}
}
