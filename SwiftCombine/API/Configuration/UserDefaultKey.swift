enum UserDefaultKey: String {
    case onboardingFinished
    case serverType
}

struct UserDefaultEnumKey {
    enum ServerType: Int {
        case production
        case stage
        case prestage
    }
}
