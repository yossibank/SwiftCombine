struct Repos {
    struct CoreData {
        typealias GetClub = CoreDataRepository<Club>
        typealias GetFruit = CoreDataRepository<Fruit>
        typealias GetStudent = CoreDataRepository<Student>
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
