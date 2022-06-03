struct SetSomeFileRequest: LocalRequest {
    typealias Response = EmptyResponse
    typealias Parameters = [String]
    typealias PathComponent = EmptyPathComponent

    var localDataInterceptor: (Parameters) -> Response? {
        { someFile in
            PersistedDataHolder.someFile = someFile
            return EmptyResponse()
        }
    }

    init(parameters: Parameters, pathComponent: PathComponent) {}
}
