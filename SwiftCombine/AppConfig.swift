import Firebase

struct AppConfig {
    static let isTesting = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil

    static func setup() {
        // FirebaseApp.configure()
        Analytics.shared.provider = FirebaseProvider()
    }
}
