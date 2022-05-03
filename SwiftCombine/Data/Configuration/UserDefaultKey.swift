enum UserDefaultKey: String {
    case onboardingFinished
    case serverType
    case jokeId
}

struct UserDefaultEnumKey {
    enum ServerType: Int {
        case production
        case stage
        case prestage
    }
}
