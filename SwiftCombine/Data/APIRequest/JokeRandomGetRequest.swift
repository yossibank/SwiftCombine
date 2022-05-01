import Foundation

struct JokeRandomGetRequest: Request {
    typealias Response = JokeRandomResponse
    typealias Parameters = EmptyParameters
    typealias PathComponent = EmptyPathComponent

    let parameters: Parameters
    var method: HTTPMethod { .get }
    var path: String { "" }
    var testDataPath: URL? {
        Bundle.main.url(forResource: "GetJokeRandom", withExtension: "json")
    }

    var body: Data?

    init(
        parameters: Parameters = .init(),
        pathComponent: PathComponent = .init()
    ) {
        self.parameters = parameters
    }
}
