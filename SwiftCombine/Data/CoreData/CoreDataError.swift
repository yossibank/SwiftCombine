import Foundation

enum CoreDataError: LocalizedError, Equatable {
    case failed(String)
    case unknwon

    var errorDescription: String? {
        switch self {
        case let .failed(error):
            return "failed error: \(error)"

        case .unknwon:
            return "unknown error occured"
        }
    }
}
