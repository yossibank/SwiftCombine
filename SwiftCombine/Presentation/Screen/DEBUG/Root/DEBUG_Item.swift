enum DEBUG_Section: String, CaseIterable {
    case development
    case userDefault
    case api
    case coreData
    case combine
    case fileManager

    var items: [DEBUG_Item] {
        switch self {
        case .development:
            return DEBUG_Development.allCases.map { $0.component }

        case .userDefault:
            return DEBUG_UserDefault.allCases.map { $0.component }

        case .api:
            return DEBUG_API.allCases.map { $0.component }

        case .coreData:
            return DEBUG_CoreData.allCases.map { $0.component }

        case .combine:
            return DEBUG_Combine.allCases.map { $0.component }

        case .fileManager:
            return DEBUG_FileStorage.allCases.map { $0.component }
        }
    }
}

enum DEBUG_Item: Hashable {
    case development(DEBUG_Development)
    case userDefault(DEBUG_UserDefault)
    case api(DEBUG_API)
    case coreData(DEBUG_CoreData)
    case combine(DEBUG_Combine)
    case fileManager(DEBUG_FileStorage)
}

enum DEBUG_Development: String, CaseIterable, Hashable {
    case server

    var component: DEBUG_Item {
        switch self {
        case .server:
            return .development(.server)
        }
    }

    enum ServerItem: String, CaseIterable, Hashable {
        case production = "本番"
        case stage = "ステージ"
        case prestage = "プレステージ"
    }
}

enum DEBUG_UserDefault: String, CaseIterable, Hashable {
    case jokeId

    var component: DEBUG_Item {
        switch self {
        case .jokeId:
            return .userDefault(.jokeId)
        }
    }
}

enum DEBUG_API: String, CaseIterable, Hashable {
    case get
    case random
    case search
    case slack

    var component: DEBUG_Item {
        switch self {
        case .get:
            return .api(.get)

        case .random:
            return .api(.random)

        case .search:
            return .api(.search)

        case .slack:
            return .api(.slack)
        }
    }
}

enum DEBUG_CoreData: String, CaseIterable, Hashable {
    case fruit
    case student

    var component: DEBUG_Item {
        switch self {
        case .fruit:
            return .coreData(.fruit)

        case .student:
            return .coreData(.student)
        }
    }
}

enum DEBUG_Combine: String, CaseIterable, Hashable {
    case just
    case subject
    case future
    case deferred

    var component: DEBUG_Item {
        switch self {
        case .just:
            return .combine(.just)

        case .subject:
            return .combine(.subject)

        case .future:
            return .combine(.future)

        case .deferred:
            return .combine(.deferred)
        }
    }
}

enum DEBUG_FileStorage: String, CaseIterable, Hashable {
    case someFile

    var component: DEBUG_Item {
        switch self {
        case .someFile:
            return .fileManager(.someFile)
        }
    }
}
