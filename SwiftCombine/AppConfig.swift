import Firebase

struct AppConfig {
    static func setup() {
        // FirebaseApp.configure()
        Analytics.shared.provider = FirebaseProvider()
    }
}
