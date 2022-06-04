enum JokeSearchSection: String, CaseIterable {
    case main
}

struct JokeSearchItem: Hashable {
    let id: String
    let joke: String
}
