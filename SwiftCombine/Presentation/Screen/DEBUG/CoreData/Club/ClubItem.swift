enum ClubSection: String, CaseIterable {
    case main
}

struct ClubItem: Hashable {
    let name: String
    let money: Int
    let place: String
    let schedule: String
    let students: [StudentItem]

    struct StudentItem: Hashable {
        let name: String
    }
}
