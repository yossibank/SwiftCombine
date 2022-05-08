import Foundation

protocol AnalyticsProvider {
    func sendEvent(title: String)
}

final class Analytics {
    var provider: AnalyticsProvider?

    static let shared: Analytics = .init()
    private init() {}

    func sendEvent(title: String = #function) {
        provider?.sendEvent(title: title)
    }
}
