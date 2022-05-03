struct AppDataHolder {
    @UserDefaultsEnumStorage(UserDefaultKey.serverType.rawValue, defaultValue: .stage)
    static var serverType: UserDefaultEnumKey.ServerType

    @UserDefaultsStorage(UserDefaultKey.jokeId.rawValue, defaultValue: "")
    static var jokeId: String
}
