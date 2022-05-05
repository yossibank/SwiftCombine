// MARK: - CoreData

typealias ClubModel = ModelImpl<Repos.Local.ClubCoreData, ClubMapper>
typealias FruitModel = ModelImpl<Repos.Local.FruitCoreData, FruitMapper>
typealias StudentModel = ModelImpl<Repos.Local.StudentCoreData, StudentMapper>

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
        static func Club(useTestData: Bool = false) -> ClubModel {
            .init(
                repository: Repos.Local.ClubCoreData(useTestData: useTestData),
                mapper: ClubMapper()
            )
        }

        static func Fruit(useTestData: Bool = false) -> FruitModel {
            .init(
                repository: Repos.Local.FruitCoreData(useTestData: useTestData),
                mapper: FruitMapper()
            )
        }

        static func Student(useTestData: Bool = false) -> StudentModel {
            .init(
                repository: Repos.Local.StudentCoreData(useTestData: useTestData),
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
