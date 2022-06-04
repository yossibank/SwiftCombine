struct AppDataHolder {
    @UserDefaultsEnumStorage(UserDefaultKey.serverType.rawValue, defaultValue: .production)
    static var serverType: UserDefaultEnumKey.ServerType

    @UserDefaultsStorage(UserDefaultKey.jokeId.rawValue, defaultValue: "")
    static var jokeId: String
}
