typealias JokeModel = ModelImpl<Repos.Joke>
typealias GetOnboardingModel = ModelImpl<Repos.Onboarding.GetIsFinished>
typealias SetOnboardingModel = ModelImpl<Repos.Onboarding.SetIsFinished>

struct Model {
    static func Joke(useTestData: Bool = false) -> JokeModel {
        .init(
            repository: Repos.Joke(),
            useTestData: useTestData
        )
    }

    struct Onboarding {
        static func get() -> GetOnboardingModel {
            .init(repository: Repos.Onboarding.GetIsFinished())
        }

        static func set() -> SetOnboardingModel {
            .init(repository: Repos.Onboarding.SetIsFinished())
        }
    }
}
