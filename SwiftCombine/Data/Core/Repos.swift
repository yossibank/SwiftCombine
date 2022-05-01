struct Repos {
    struct Joke {
        typealias Random = Repository<JokeRandomGetRequest>
        typealias Slack = Repository<JokeSlackGetRequest>
    }

    struct Onboarding {
        typealias GetIsFinished = Repository<GetOnboardingFinishedRequest>
        typealias SetIsFinished = Repository<SetOnboardingFinishedRequest>
    }
}
