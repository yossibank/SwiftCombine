import Foundation

struct EmptyParameters: Encodable, Equatable {}
struct EmptyResponse: Codable, Equatable {}
struct EmptyPathComponent {}

enum APIRequestHeader: String, CaseIterable {
    case accept = "Accept"
    case userAgent = "User-Agent"

    var value: String? {
        switch self {
        case .accept:
            return "application/json"

        case .userAgent:
            return "[GitHub] https://github.com/yossibank/SwiftCombine"
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

struct HTTPStatusCode {
    static let noContent = 204
    static let successRange = 200...299
    static let unauthorized = 401
    static let notFound = 404
    static let unprocessableEntity = 422
}

protocol Request {
    associatedtype Response: Decodable
    associatedtype Parameters: Encodable
    associatedtype PathComponent

    // 必須要素
    var parameters: Parameters { get }
    var method: HTTPMethod { get }
    var path: String { get }

    #if DEBUG
    var testDataPath: URL? { get }
    #endif

    // オプション要素
    var baseURL: String { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
    var headers: [String: String] { get }
    var wantCache: Bool { get }
    var localDataInterceptor: (Parameters) -> Response? { get }
    var successHandler: (Response) -> Void { get }
    var failureHandler: (Error) -> Void { get }

    init(
        parameters: Parameters,
        pathComponent: PathComponent
    )
}

extension Request {

    var baseURL: String {
        "https://icanhazdadjoke.com"
    }

    var queryItems: [URLQueryItem]? {
        let query: [URLQueryItem]

        if let p = parameters as? [Encodable] {
            query = p.flatMap { param in param.dictionary.map { key, value in
                URLQueryItem(name: key, value: value?.description ?? "")
            }}
        } else {
            query = parameters.dictionary.map { key, value in
                URLQueryItem(name: key, value: value?.description ?? "")
            }
        }

        return query.sorted { first, second in
            first.name < second.name
        }
    }

    var body: Data? {
        try? JSONEncoder().encode(parameters)
    }

    var headers: [String: String] {
        var dic: [String: String] = [:]

        APIRequestHeader.allCases.forEach { header in
            dic[header.rawValue] = header.value
        }

        return dic
    }

    var wantCache: Bool { false }

    var localDataInterceptor: (Parameters) -> Response? {{ _ in nil }}

    var successHandler: (Response) -> Void {{ _ in }}

    var failureHandler: (Error) -> Void {{ _ in }}
}

private extension Encodable {
    var dictionary: [String: CustomStringConvertible?] {
        (
            try? JSONSerialization.jsonObject(
                with: JSONEncoder().encode(self)
            )
        ) as? [String: CustomStringConvertible?] ?? [:]
    }
}
