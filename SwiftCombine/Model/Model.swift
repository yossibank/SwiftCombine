// MARK: - CoreData

typealias FruitModel = ModelImpl<Repos.CoreDataFruit, FruitMapper>
typealias StudentModel = ModelImpl<Repos.CoreDataStudent, StudentMapper>

// MARK: - Joke

typealias JokeModel = ModelImpl<Repos.Joke.Get, JokeMapper>
typealias JokeRandomModel = ModelImpl<Repos.Joke.Random, JokeMapper>
typealias JokeSearchModel = ModelImpl<Repos.Joke.Search, JokeSearchMapper>
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

        static func Student(useTestData: Bool = false) -> StudentModel {
            .init(
                repository: Repos.CoreDataStudent(useTestData: useTestData),
                mapper: StudentMapper()
            )
        }
    }

    struct Joke {
        static func Get(useTestData: Bool = false) -> JokeModel {
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

        static func Search(useTestData: Bool = false) -> JokeSearchModel {
            .init(
                repository: Repos.Joke.Search(),
                mapper: JokeSearchMapper(),
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
