struct PersistedDataHolder {
    @UserDefaultsStorage(UserDefaultKey.onboardingFinished.rawValue, defaultValue: false)
    static var onboardingFinished: Bool
}
