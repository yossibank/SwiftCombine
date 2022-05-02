// MARK: - CoreData

typealias FruitModel = ModelImpl<Repos.CoreDataFruit, FruitMapper>

// MARK: - Joke

typealias JokeRandomModel = ModelImpl<Repos.Joke.Random, JokeRandomMapper>
typealias JokeSlackModel = ModelImpl<Repos.Joke.Slack, JokeSlackMapper>

// MARK: - Onboarding

typealias GetOnboardingModel = ModelImpl<Repos.Onboarding.GetIsFinished, NoMapper>
typealias SetOnboardingModel = ModelImpl<Repos.Onboarding.SetIsFinished, NoMapper>

struct Model {
    struct CoreData {
        static func Fruit() -> FruitModel {
            .init(
                repository: Repos.CoreDataFruit(),
                mapper: FruitMapper()
            )
        }
    }

    struct Joke {
        static func Random(useTestData: Bool = false) -> JokeRandomModel {
            .init(
                repository: Repos.Joke.Random(),
                mapper: JokeRandomMapper(),
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
