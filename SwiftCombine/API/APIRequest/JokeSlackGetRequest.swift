import Foundation

struct JokeSlackGetRequest: Request {
    typealias Response = JokeSlackResponse
    typealias Parameters = EmptyParameters
    typealias PathComponent = EmptyPathComponent

    let parameters: Parameters
    var method: HTTPMethod { .get }
    var path: String { "/slack" }
    var testDataPath: URL? {
        nil
    }

    var body: Data?

    init(
        parameters: Parameters = .init(),
        pathComponent: PathComponent = .init()
    ) {
        self.parameters = parameters
    }
}
