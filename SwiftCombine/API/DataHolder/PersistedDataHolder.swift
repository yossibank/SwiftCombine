struct PersistedDataHolder {
    @UserDefaultsStorage(key: UserDefaultKey.onboardingFinished.rawValue)
    static var onboardingFinished: Bool?
}
