import Foundation

@propertyWrapper
final class UserDefaultsStorage<T: Equatable> {
    enum UserDefaultsType {
        case `default`
        case mock
    }

    private var userDefaults: UserDefaults? {
        switch type {
        case .default:
            return UserDefaults.standard

        case .mock:
            return UserDefaults(suiteName: "mock")
        }
    }

    private let key: String
    private let defaultValue: T
    private let type: UserDefaultsType

    init(_ key: String, defaultValue: T, type: UserDefaultsType = .default) {
        self.key = key
        self.defaultValue = defaultValue
        self.type = type
    }

    var wrappedValue: T {
        get {
            userDefaults?.object(forKey: key) as? T ?? defaultValue
        }
        set {
            if newValue == defaultValue {
                userDefaults?.removeObject(forKey: key)
            }

            userDefaults?.set(newValue, forKey: key)
        }
    }
}

@propertyWrapper
final class UserDefaultsEnumStorage<T: RawRepresentable & Equatable> {
    enum UserDefaultsType {
        case `default`
        case mock
    }

    private var userDefaults: UserDefaults? {
        switch type {
        case .default:
            return UserDefaults.standard

        case .mock:
            return UserDefaults(suiteName: "mock")
        }
    }

    private let key: String
    private let defaultValue: T
    private let type: UserDefaultsType

    init(_ key: String, defaultValue: T, type: UserDefaultsType = .default) {
        self.key = key
        self.defaultValue = defaultValue
        self.type = type
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
