enum DEBUG_Section: String, CaseIterable {
    case viewController
    case coreData
    case combine

    var items: [DEBUG_Item] {
        switch self {
        case .viewController:
            return DEBUG_Controller.allCases.map { $0.component }

        case .coreData:
            return DEBUG_CoreData.allCases.map { $0.component }

        case .combine:
            return DEBUG_Combine.allCases.map { $0.component }
        }
    }
}

enum DEBUG_Item: Hashable {
    case controller(DEBUG_Controller)
    case coreData(DEBUG_CoreData)
    case combine(DEBUG_Combine)
}

enum DEBUG_Controller: String, CaseIterable, Hashable {
    case api

    var component: DEBUG_Item {
        .controller(.api)
    }
}

enum DEBUG_CoreData: String, CaseIterable, Hashable {
    case sample

    var component: DEBUG_Item {
        .coreData(.sample)
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
