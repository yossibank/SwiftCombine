struct Repos {
    struct Local {
        typealias ClubCoreData = CoreDataRepository<Club>
        typealias FruitCoreData = CoreDataRepository<Fruit>
        typealias StudentCoreData = CoreDataRepository<Student>
    }

    struct Joke {
        typealias Get = Repository<JokeRequest>
        typealias Random = Repository<JokeRandomRequest>
        typealias Search = Repository<JokeSearchRequest>
        typealias Slack = Repository<JokeSlackRequest>
    }

    struct Onboarding {
        typealias GetIsFinished = Repository<GetOnboardingFinishedRequest>
        typealias SetIsFinished = Repository<SetOnboardingFinishedRequest>
    }
}
