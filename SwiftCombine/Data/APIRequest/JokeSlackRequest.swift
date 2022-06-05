import Foundation

struct JokeSlackRequest: Request {
    typealias Response = JokeSlackResponse
    typealias Parameters = EmptyParameters
    typealias PathComponent = EmptyPathComponent

    let parameters: Parameters
    var method: HTTPMethod { .get }
    var path: String { "/slack" }
    var testDataPath: URL? {
        Bundle.main.url(forResource: "GetJokeSlack", withExtension: "json")
    }

    var body: Data?

    var successHandler: (Response) -> Void {
        { response in
            CoreDataStorage.insert(
                object: Student.create(
                    entity: .init(
                        name: response.username,
                        age: 100,
                        number: 100
                    )
                )
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
