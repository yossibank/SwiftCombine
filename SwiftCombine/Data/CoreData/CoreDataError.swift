import Foundation

enum CoreDataError: LocalizedError, Equatable {
    case unknwon
    case failed(String)

    var errorDescription: String? {
        switch self {
        case .unknwon:
            return "unknown error occured"

        case let .failed(error):
            return "failed error: \(error)"
        }
    }
}
