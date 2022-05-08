struct SecretDataHolder {
    @KeychainStorage(key: KeychainKey.accessToken.rawValue)
    static var accessToken: String?
}
