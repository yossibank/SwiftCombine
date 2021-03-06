enum PersistedDataHolder {
    @UserDefaultsStorage(UserDefaultsKey.onboardingFinished.rawValue, defaultValue: false)
    static var onboardingFinished: Bool

    @FileStorage(fileName: FileName.someFile.rawValue)
    static var someFile: [String]?
}
