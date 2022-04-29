struct AppDataHolder {
    @UserDefaultsEnumStorage(UserDefaultKey.serverType.rawValue, defaultValue: .stage)
    static var serverType: UserDefaultEnumKey.ServerType
}
