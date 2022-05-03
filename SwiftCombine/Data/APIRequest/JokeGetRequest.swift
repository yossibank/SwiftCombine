import Foundation

struct JokeGetRequest: Request {
    typealias Response = JokeResponse
    typealias Parameters = EmptyParameters

    private let jokeId: String

    let parameters: Parameters
    var method: HTTPMethod { .get }
    var path: String { "/j/\(jokeId)" }
    var testDataPath: URL? {
        nil
    }

    var body: Data?

    init(
        parameters: Parameters = .init(),
        pathComponent jokeId: String
    ) {
        self.parameters = parameters
        self.jokeId = jokeId
    }
}
