import Foundation

struct JokeGetRequest: Request {
    typealias Response = JokeResponse
    typealias Parameters = EmptyParameters
    typealias PathComponent = EmptyPathComponent

    let parameters: Parameters
    var method: HTTPMethod { .get }
    var path: String { "" }
    var testDataPath: URL? { nil }

    var body: Data?

    init(
        parameters: Parameters = .init(),
        pathComponent: PathComponent = .init()
    ) {
        self.parameters = parameters
    }
}
