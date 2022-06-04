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
            guard !CoreDataHolder.fruits.map(\.name).contains(response.joke) else {
                return
            }

            CoreDataStorageManager.insert(object: Fruit(name: response.joke))
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
