struct JokeSearchResponse: DataStructure {
    let currentPage: Int
    let limit: Int
    let nextPage: Int
    let previousPage: Int
    let results: [JokeSearchResult]
    let searchTerm: String
    let status: Int
    let totalJokes: Int
    let totalPages: Int

    struct JokeSearchResult: DataStructure {
        let id: String
        let joke: String
    }
}
