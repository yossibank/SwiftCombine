struct GetSomeFileRequest: LocalRequest {
    typealias Response = [String]
    typealias Parameters = EmptyParameters
    typealias PathComponent = EmptyPathComponent

    var localDataInterceptor: (Parameters) -> Response? {
        { _ in
            PersistedDataHolder.someFile
        }
    }

    init(parameters: Parameters, pathComponent: PathComponent) {}
}
