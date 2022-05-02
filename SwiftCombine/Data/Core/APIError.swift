import Foundation

enum APIError: LocalizedError, Equatable {
    case missingTestJsonDataPath
    case invalidRequest
    case offline
    case decodeError(String)
    case responseError
    case unknown

    var errorDescription: String? {
        switch self {
        case .missingTestJsonDataPath:
            return "missing test json data path"

        case .invalidRequest:
            return "invalid request"

        case .offline:
            return "offline error occured"

        case let .decodeError(error):
            return "decode error occured: \(error)"

        case .responseError:
            return "response error occured"

        case .unknown:
            return "unknown error occured"
        }
    }
}
