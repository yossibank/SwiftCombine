import Combine

struct NoRepository {}
struct NoMapper {}

protocol Usecase {
    associatedtype Repository
    associatedtype Mapper

    var repository: Repository { get }
    var mapper: Mapper { get }
    var analytics: Analytics { get }
}

struct UsecaseImpl<R, M>: Usecase {
    var repository: R
    var mapper: M
    var analytics: Analytics = .shared
    var useTestData: Bool = false

    func toPublisher<T: Equatable, E: Error>(
        closure: @escaping (@escaping Future<T, E>.Promise) -> Void
    ) -> AnyPublisher<T, E> {
        Deferred {
            Future { promise in
                closure(promise)
            }
        }.eraseToAnyPublisher()
    }
}

// MARK: - CoreData

typealias ClubUsecase = UsecaseImpl<Repos.Local.ClubCoreData, ClubMapper>
typealias FruitUsecase = UsecaseImpl<Repos.Local.FruitCoreData, FruitMapper>
typealias StudentUsecase = UsecaseImpl<Repos.Local.StudentCoreData, StudentMapper>

// MARK: - Joke

typealias JokeUsecase = UsecaseImpl<Repos.Joke.Get, JokeMapper>
typealias JokeRandomUsecase = UsecaseImpl<Repos.Joke.Random, JokeMapper>
typealias JokeSearchUsecase = UsecaseImpl<Repos.Joke.Search, JokeSearchMapper>
typealias JokeSlackUsecase = UsecaseImpl<Repos.Joke.Slack, JokeSlackMapper>

// MARK: - Onboarding

typealias GetOnboardingUsecase = UsecaseImpl<Repos.Onboarding.GetIsFinished, NoMapper>
typealias SetOnboardingUsecase = UsecaseImpl<Repos.Onboarding.SetIsFinished, NoMapper>

// MARK: - SomeFile

typealias GetSomeFileUsecase = UsecaseImpl<Repos.SomeFile.Get, NoMapper>
typealias SetSomeFileUsecase = UsecaseImpl<Repos.SomeFile.Set, NoMapper>
