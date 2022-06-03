struct GetFruitRequest: LocalRequest {
    typealias Response = [Fruit]
    typealias Parameters = EmptyParameters
    typealias PathComponent = EmptyPathComponent

    var localDataInterceptor: (Parameters) -> Response? {
        { _ in
            CoreDataHolder.fruits
        }
    }

    init(parameters: Parameters, pathComponent: PathComponent) {}
}
