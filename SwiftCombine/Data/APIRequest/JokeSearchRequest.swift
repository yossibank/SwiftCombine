import Foundation

struct JokeSearchRequest: Request {
    typealias Response = JokeSearchResponse
    typealias PathComponent = EmptyPathComponent

    struct Parameters: Codable {
        let page: Int
        let limit: Int
        let term: String

        init(
            page: Int = 1,
            limit: Int = 20,
            term: String = ""
        ) {
            self.page = page
            self.limit = limit
            self.term = term
        }
    }

    let parameters: Parameters
    var method: HTTPMethod { .get }
    var path: String { "/search" }
    var testDataPath: URL? {
        Bundle.main.url(forResource: "GetJokeSearch", withExtension: "json")
    }

    var body: Data?

    init(
        parameters: Parameters,
        pathComponent: PathComponent = .init()
    ) {
        self.parameters = parameters
    }
}
