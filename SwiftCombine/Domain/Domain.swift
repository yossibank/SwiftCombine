struct Domain {
    struct Usecase {
        struct CoreData {
            static func Club() -> ClubUsecase {
                .init(
                    resource: Repos.Local.ClubCoreData(),
                    mapper: ClubMapper()
                )
            }

            static func Fruit() -> FruitUsecase {
                .init(
                    resource: Repos.Local.FruitCoreData(),
                    mapper: FruitMapper()
                )
            }

            static func Student() -> StudentUsecase {
                .init(
                    resource: Repos.Local.StudentCoreData(),
                    mapper: StudentMapper()
                )
            }
        }

        struct Joke {
            static func Get(useTestData: Bool = false) -> JokeUsecase {
                .init(
                    resource: Repos.Joke.Get(),
                    mapper: JokeMapper(),
                    useTestData: useTestData
                )
            }

            static func Random(useTestData: Bool = false) -> JokeRandomUsecase {
                .init(
                    resource: Repos.Joke.Random(),
                    mapper: JokeMapper(),
                    useTestData: useTestData
                )
            }

            static func Search(useTestData: Bool = false) -> JokeSearchUsecase {
                .init(
                    resource: Repos.Joke.Search(),
                    mapper: JokeSearchMapper(),
                    useTestData: useTestData
                )
            }

            static func Slack(useTestData: Bool = false) -> JokeSlackUsecase {
                .init(
                    resource: Repos.Joke.Slack(),
                    mapper: JokeSlackMapper(),
                    useTestData: useTestData
                )
            }
        }

        struct Onboarding {
            static func Get() -> GetOnboardingUsecase {
                .init(
                    resource: Repos.Onboarding.GetIsFinished(),
                    mapper: NoMapper()
                )
            }

            static func Set() -> SetOnboardingUsecase {
                .init(
                    resource: Repos.Onboarding.SetIsFinished(),
                    mapper: NoMapper()
                )
            }
        }

        struct SomeFile {
            static func Get() -> GetSomeFileUsecase {
                .init(
                    resource: Repos.SomeFile.Get(),
                    mapper: NoMapper()
                )
            }

            static func Set() -> SetSomeFileUsecase {
                .init(
                    resource: Repos.SomeFile.Set(),
                    mapper: NoMapper()
                )
            }
        }
    }
}
