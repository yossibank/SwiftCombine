struct JokeSearchMapper {
    func convert(response: JokeSearchResponse) -> JokeSearchEntity {
        .init(
            currentPage: response.currentPage,
            limit: response.limit,
            nextPage: response.nextPage,
            previousPage: response.previousPage,
            results: response.results.map {
                .init(
                    id: $0.id,
                    joke: $0.joke
                )
            },
            searchTerm: response.searchTerm,
            status: response.status,
            totalJokes: response.totalJokes,
            totalPages: response.totalPages
        )
    }
}
