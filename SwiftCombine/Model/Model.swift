// MARK: - Joke

typealias JokeRandomModel = ModelImpl<Repos.Joke.Random>
typealias JokeSlackModel = ModelImpl<Repos.Joke.Slack>

// MARK: - Onboarding

typealias GetOnboardingModel = ModelImpl<Repos.Onboarding.GetIsFinished>
typealias SetOnboardingModel = ModelImpl<Repos.Onboarding.SetIsFinished>

struct Model {
    struct Joke {
        static func Random(useTestData: Bool = false) -> JokeRandomModel {
            .init(
                repository: Repos.Joke.Random(),
                useTestData: useTestData
            )
        }

        static func Slack(useTestData: Bool = false) -> JokeSlackModel {
            .init(
                repository: Repos.Joke.Slack(),
                useTestData: useTestData
            )
        }
    }

    struct Onboarding {
        static func Get() -> GetOnboardingModel {
            .init(repository: Repos.Onboarding.GetIsFinished())
        }

        static func Set() -> SetOnboardingModel {
            .init(repository: Repos.Onboarding.SetIsFinished())
        }
    }
}
