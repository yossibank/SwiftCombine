struct GetOnboardingFinishedRequest: LocalRequest {
    typealias Response = Bool
    typealias Parameters = EmptyParameters
    typealias PathComponent = EmptyPathComponent

    var localDataInterceptor: (Parameters) -> Response? {
        { _ in
            PersistedDataHolder.onboardingFinished
        }
    }

    init(parameters: Parameters, pathComponent: PathComponent) {}
}
