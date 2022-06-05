import Foundation

struct JokeRequest: Request {
    typealias Response = JokeResponse
    typealias Parameters = EmptyParameters

    private let jokeId: String

    let parameters: Parameters
    var method: HTTPMethod { .get }
    var path: String { "/j/\(jokeId)" }
    var testDataPath: URL? {
        Bundle.main.url(forResource: "GetJoke", withExtension: "json")
    }

    var body: Data?

    var successHandler: (Response) -> Void {
        { response in
            CoreDataStorage.insert(
                object: Fruit.create(
                    entity: .init(name: response.joke)
                )
            )
        }
    }

    init(
        parameters: Parameters = .init(),
        pathComponent jokeId: String
    ) {
        self.parameters = parameters
        self.jokeId = jokeId
    }
}
