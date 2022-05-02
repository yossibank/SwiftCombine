struct Repos {
    typealias CoreDataFruit = CoreDataRepository<Fruit>

    struct Joke {
        typealias Random = Repository<JokeRandomGetRequest>
        typealias Slack = Repository<JokeSlackGetRequest>
    }

    struct Onboarding {
        typealias GetIsFinished = Repository<GetOnboardingFinishedRequest>
        typealias SetIsFinished = Repository<SetOnboardingFinishedRequest>
    }
}
