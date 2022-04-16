import Foundation

protocol LocalRequest: Request {}

extension LocalRequest {
    var method: HTTPMethod { fatalError() }
    var parameters: Parameters { fatalError() }
    var path: String { fatalError() }
    var testDataPath: URL? { nil }
}
