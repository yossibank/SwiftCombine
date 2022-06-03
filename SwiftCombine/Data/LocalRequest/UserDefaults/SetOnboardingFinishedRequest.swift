struct SetOnboardingFinishedRequest: LocalRequest {
    typealias Response = EmptyResponse
    typealias Parameters = Bool
    typealias PathComponent = EmptyPathComponent

    var localDataInterceptor: (Parameters) -> Response? {
        { finished in
            PersistedDataHolder.onboardingFinished = finished
            return EmptyResponse()
        }
    }

    init(parameters: Parameters, pathComponent: PathComponent) {}
}
