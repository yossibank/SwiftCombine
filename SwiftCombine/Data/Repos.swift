struct Repos {
    struct Local {
        typealias Club = RepositoryImpl<GetClubRequest>
        typealias Fruit = RepositoryImpl<GetFruitRequest>
        typealias Student = RepositoryImpl<GetStudentRequest>
    }

    struct Joke {
        typealias Get = RepositoryImpl<JokeRequest>
        typealias Random = RepositoryImpl<JokeRandomRequest>
        typealias Search = RepositoryImpl<JokeSearchRequest>
        typealias Slack = RepositoryImpl<JokeSlackRequest>
    }

    struct Onboarding {
        typealias GetIsFinished = RepositoryImpl<GetOnboardingFinishedRequest>
        typealias SetIsFinished = RepositoryImpl<SetOnboardingFinishedRequest>
    }

    struct SomeFile {
        typealias Get = RepositoryImpl<GetSomeFileRequest>
        typealias Set = RepositoryImpl<SetSomeFileRequest>
    }

    struct AccessToken {
        typealias Get = RepositoryImpl<GetAccessTokenRequest>
        typealias Set = RepositoryImpl<SetAccessTokenRequest>
    }
}
