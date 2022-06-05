import Foundation

struct JokeRandomRequest: Request {
    typealias Response = JokeResponse
    typealias Parameters = EmptyParameters
    typealias PathComponent = EmptyPathComponent

    let parameters: Parameters
    var method: HTTPMethod { .get }
    var path: String { "" }
    var testDataPath: URL? {
        Bundle.main.url(forResource: "GetJokeRandom", withExtension: "json")
    }

    var body: Data?

    var successHandler: (Response) -> Void {
        { response in
            AppDataHolder.jokeId = response.id

            CoreDataStorage.insert(
                object: Fruit.create(name: response.joke)
            )
        }
    }

    init(
        parameters: Parameters = .init(),
        pathComponent: PathComponent = .init()
    ) {
        self.parameters = parameters
    }
}
