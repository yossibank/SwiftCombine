enum StudentSection: String, CaseIterable {
    case main
}

struct StudentItem: Hashable {
    let name: String
    let age: Int
    let number: Int
    var clubName: String?
}
