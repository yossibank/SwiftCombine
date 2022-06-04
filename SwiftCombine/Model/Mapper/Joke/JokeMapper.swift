struct JokeMapper {
    func convert(response: JokeResponse) -> JokeEntity {
        .init(
            id: response.id,
            joke: response.joke,
            status: response.status
        )
    }
}
