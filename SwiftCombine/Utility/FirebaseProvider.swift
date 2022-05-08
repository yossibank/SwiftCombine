import Firebase

struct FirebaseProvider: AnalyticsProvider {
    func sendEvent(title: String) {
        // 送るイベントを記載
        Firebase.Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(title)",
            AnalyticsParameterItemName: title,
            AnalyticsParameterContentType: "content"
        ])
    }
}
