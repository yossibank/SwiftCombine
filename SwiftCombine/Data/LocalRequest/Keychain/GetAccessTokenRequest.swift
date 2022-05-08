struct GetAccessTokenRequest: LocalRequest {
    typealias Response = String
    typealias Parameters = EmptyParameters
    typealias PathComponent = EmptyPathComponent

    var localDataInterceptor: (Parameters) -> Response? {
        { _ in
            SecretDataHolder.accessToken
        }
    }

    init(
        parameters: EmptyParameters,
        pathComponent: EmptyPathComponent
    ) {}
}
