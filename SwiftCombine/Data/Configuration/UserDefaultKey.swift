enum UserDefaultsKey: String {
    case onboardingFinished
    case serverType
    case jokeId
}

enum UserDefaultsEnum {
    enum ServerType: Int {
        case production
        case stage
        case prestage
    }
}
