typealias JokeModel = ModelImpl<Repos.Joke>

struct Model {
    static func Joke(useTestData: Bool = false) -> JokeModel {
        .init(
            repository: Repos.Joke(),
            useTestData: useTestData
        )
    }
}
