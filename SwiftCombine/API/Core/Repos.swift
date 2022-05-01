struct Repos {
    typealias Joke = Repository<JokeGetRequest>
    typealias JokeSlack = Repository<JokeSlackGetRequest>

    struct Onboarding {
        typealias GetIsFinished = Repository<GetOnboardingFinishedRequest>
        typealias SetIsFinished = Repository<SetOnboardingFinishedRequest>
    }
}
