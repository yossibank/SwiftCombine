import Combine

struct NoRepository {}
struct NoMapper {}

protocol Usecase {
    associatedtype Resource
    associatedtype Mapper

    var resource: Resource { get }
    var mapper: Mapper { get }
    var analytics: Analytics { get }
}

struct UsecaseImpl<R, M>: Usecase {
    var resource: R
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

typealias ClubUsecase = UsecaseImpl<Repos.Local.Club, ClubMapper>
typealias FruitUsecase = UsecaseImpl<Repos.Local.Fruit, FruitMapper>
typealias StudentUsecase = UsecaseImpl<Repos.Local.Student, StudentMapper>

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
