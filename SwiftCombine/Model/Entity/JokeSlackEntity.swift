struct JokeSlackEntity: Equatable {
    let attachments: [Context]
    let responseType: String
    let username: String

    struct Context: Equatable {
        let fallback: String
        let footer: String
        let text: String
    }
}
