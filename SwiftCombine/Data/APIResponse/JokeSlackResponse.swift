struct JokeSlackResponse: DataStructure {
    let attachments: [Context]
    let responseType: String
    let username: String

    struct Context: DataStructure {
        let fallback: String
        let footer: String
        let text: String
    }
}
