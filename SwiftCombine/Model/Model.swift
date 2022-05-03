// MARK: - CoreData

typealias FruitModel = ModelImpl<Repos.CoreDataFruit, FruitMapper>

// MARK: - Joke

typealias JokeGetModel = ModelImpl<Repos.Joke.Get, JokeMapper>
typealias JokeRandomModel = ModelImpl<Repos.Joke.Random, JokeMapper>
typealias JokeSlackModel = ModelImpl<Repos.Joke.Slack, JokeSlackMapper>

// MARK: - Onboarding

typealias GetOnboardingModel = ModelImpl<Repos.Onboarding.GetIsFinished, NoMapper>
typealias SetOnboardingModel = ModelImpl<Repos.Onboarding.SetIsFinished, NoMapper>

struct Model {
    struct CoreData {
        static func Fruit(useTestData: Bool = false) -> FruitModel {
            .init(
                repository: Repos.CoreDataFruit(useTestData: useTestData),
                mapper: FruitMapper()
            )
        }
    }

    struct Joke {
        static func Get(useTestData: Bool = false) -> JokeGetModel {
            .init(
                repository: Repos.Joke.Get(),
                mapper: JokeMapper(),
                useTestData: useTestData
            )
        }

        static func Random(useTestData: Bool = false) -> JokeRandomModel {
            .init(
                repository: Repos.Joke.Random(),
                mapper: JokeMapper(),
                useTestData: useTestData
            )
        }

        static func Slack(useTestData: Bool = false) -> JokeSlackModel {
            .init(
                repository: Repos.Joke.Slack(),
                mapper: JokeSlackMapper(),
                useTestData: useTestData
            )
        }
    }

    struct Onboarding {
        static func Get() -> GetOnboardingModel {
            .init(
                repository: Repos.Onboarding.GetIsFinished(),
                mapper: NoMapper()
            )
        }

        static func Set() -> SetOnboardingModel {
            .init(
                repository: Repos.Onboarding.SetIsFinished(),
                mapper: NoMapper()
            )
        }
    }
}
