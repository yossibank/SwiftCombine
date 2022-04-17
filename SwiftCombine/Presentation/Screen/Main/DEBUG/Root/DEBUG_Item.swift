enum DEBUG_Section: String, CaseIterable {
    case api
    case combine

    var items: [DEBUG_Item] {
        switch self {
        case .api:
            return DEBUG_API.allCases.map { $0.component }

        case .combine:
            return DEBUG_Combine.allCases.map { $0.component }
        }
    }
}

enum DEBUG_Item: Hashable {
    case api(DEBUG_API)
    case combine(DEBUG_Combine)
}

enum DEBUG_API: String, CaseIterable, Hashable {
    case joke

    var component: DEBUG_Item {
        .api(.joke)
    }
}

enum DEBUG_Combine: String, CaseIterable, Hashable {
    case future

    var component: DEBUG_Item {
        .combine(.future)
    }
}
