enum DEBUG_Section: String, CaseIterable {
    case development
    case api
    case coreData
    case combine

    var items: [DEBUG_Item] {
        switch self {
        case .development:
            return DEBUG_Development.allCases.map { $0.component }

        case .api:
            return DEBUG_API.allCases.map { $0.component }

        case .coreData:
            return DEBUG_CoreData.allCases.map { $0.component }

        case .combine:
            return DEBUG_Combine.allCases.map { $0.component }
        }
    }
}

enum DEBUG_Item: Hashable {
    case development(DEBUG_Development)
    case api(DEBUG_API)
    case coreData(DEBUG_CoreData)
    case combine(DEBUG_Combine)
}

enum DEBUG_Development: String, CaseIterable, Hashable {
    case server
    case jokeId

    var component: DEBUG_Item {
        switch self {
        case .server:
            return .development(.server)

        case .jokeId:
            return .development(.jokeId)
        }
    }

    enum ServerItem: String, CaseIterable, Hashable {
        case production = "本番"
        case stage = "ステージ"
        case prestage = "プレステージ"
    }
}

enum DEBUG_API: String, CaseIterable, Hashable {
    case jokeRandom
    case jokeSlack

    var component: DEBUG_Item {
        switch self {
        case .jokeRandom:
            return .api(.jokeRandom)

        case .jokeSlack:
            return .api(.jokeSlack)
        }
    }
}

enum DEBUG_CoreData: String, CaseIterable, Hashable {
    case fruit

    var component: DEBUG_Item {
        .coreData(.fruit)
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
