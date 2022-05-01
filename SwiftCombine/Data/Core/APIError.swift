import Foundation

enum APIError: LocalizedError, Equatable {
    case unknown
    case missingTestJsonDataPath
    case invalidRequest
    case offline
    case decodeError(String)
    case responseError

    var errorDescription: String? {
        switch self {
            case .unknown:
                return "unknown error occured"

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
        }
    }
}
