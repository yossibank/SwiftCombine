struct JokeSlackMapper {
    func convert(response: JokeSlackResponse) -> JokeSlackEntity {
        .init(
            attachments: response.attachments.map {
                .init(
                    fallback: $0.fallback,
                    footer: $0.footer,
                    text: $0.text
                )
            },
            responseType: response.responseType,
            username: response.username
        )
    }
}
