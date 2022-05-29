struct Domain {
    struct Usecase {
        struct CoreData {
            static func Club() -> ClubUsecase {
                .init(
                    repository: Repos.Local.ClubCoreData(),
                    mapper: ClubMapper()
                )
            }

            static func Fruit() -> FruitUsecase {
                .init(
                    repository: Repos.Local.FruitCoreData(),
                    mapper: FruitMapper()
                )
            }

            static func Student() -> StudentUsecase {
                .init(
                    repository: Repos.Local.StudentCoreData(),
                    mapper: StudentMapper()
                )
            }
        }

        struct Joke {
            static func Get(useTestData: Bool = false) -> JokeUsecase {
                .init(
                    repository: Repos.Joke.Get(),
                    mapper: JokeMapper(),
                    useTestData: useTestData
                )
            }

            static func Random(useTestData: Bool = false) -> JokeRandomUsecase {
                .init(
                    repository: Repos.Joke.Random(),
                    mapper: JokeMapper(),
                    useTestData: useTestData
                )
            }

            static func Search(useTestData: Bool = false) -> JokeSearchUsecase {
                .init(
                    repository: Repos.Joke.Search(),
                    mapper: JokeSearchMapper(),
                    useTestData: useTestData
                )
            }

            static func Slack(useTestData: Bool = false) -> JokeSlackUsecase {
                .init(
                    repository: Repos.Joke.Slack(),
                    mapper: JokeSlackMapper(),
                    useTestData: useTestData
                )
            }
        }

        struct Onboarding {
            static func Get() -> GetOnboardingUsecase {
                .init(
                    repository: Repos.Onboarding.GetIsFinished(),
                    mapper: NoMapper()
                )
            }

            static func Set() -> SetOnboardingUsecase {
                .init(
                    repository: Repos.Onboarding.SetIsFinished(),
                    mapper: NoMapper()
                )
            }
        }

        struct SomeFile {
            static func Get() -> GetSomeFileUsecase {
                .init(
                    repository: Repos.SomeFile.Get(),
                    mapper: NoMapper()
                )
            }

            static func Set() -> SetSomeFileUsecase {
                .init(
                    repository: Repos.SomeFile.Set(),
                    mapper: NoMapper()
                )
            }
        }
    }
}
