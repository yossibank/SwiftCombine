struct JokeRandomMapper {
    func convert(response: JokeRandomResponse) -> JokeRandomEntity {
        .init(
            id: response.id,
            joke: response.joke,
            status: response.status
        )
    }
}
