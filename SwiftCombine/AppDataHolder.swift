struct AppDataHolder {
    @UserDefaultsEnumStorage(UserDefaultsKey.serverType.rawValue, defaultValue: .production)
    static var serverType: UserDefaultsEnum.ServerType

    @UserDefaultsStorage(UserDefaultsKey.jokeId.rawValue, defaultValue: "")
    static var jokeId: String
}
