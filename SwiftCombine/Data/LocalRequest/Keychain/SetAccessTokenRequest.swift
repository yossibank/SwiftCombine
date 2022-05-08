struct SetAccessTokenRequest: LocalRequest {
    typealias Response = EmptyResponse
    typealias Parameters = String
    typealias PathComponent = EmptyPathComponent

    var localDataInterceptor: (Parameters) -> Response? {
        { accessToken in
            SecretDataHolder.accessToken = accessToken
            return EmptyResponse()
        }
    }

    init(
        parameters: Parameters,
        pathComponent: EmptyPathComponent
    ) {}
}
