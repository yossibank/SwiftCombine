import Foundation

@propertyWrapper
final class UserDefaultsStorage<T: Equatable> {
    private let userDefaults: UserDefaults? = {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return UserDefaults(suiteName: "Test")
        }

        return UserDefaults.standard
    }()

    private let key: String
    private let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            userDefaults?.object(forKey: key) as? T ?? defaultValue
        }
        set {
            if newValue == defaultValue {
                userDefaults?.removeObject(forKey: key)
                return
            }

            userDefaults?.set(newValue, forKey: key)
        }
    }
}

@propertyWrapper
final class UserDefaultsEnumStorage<T: RawRepresentable & Equatable> {
    private let userDefaults: UserDefaults? = {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return UserDefaults(suiteName: "Test")
        }

        return UserDefaults.standard
    }()

    private let key: String
    private let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            guard
                let object = userDefaults?.object(forKey: key) as? T.RawValue,
                let value = T(rawValue: object)
            else {
                return defaultValue
            }

            return value
        }
        set {
            if newValue == defaultValue {
                userDefaults?.removeObject(forKey: key)
                return
            }

            userDefaults?.set(newValue.rawValue, forKey: key)
        }
    }
}
