import UIKit

struct AppControllers {
    static func home() -> HomeViewController {
        let instance = HomeViewController()
        instance.inject(viewModel: .init(), ui: .init())
        instance.title = "Home"
        return instance
    }

    static func debug() -> DEBUG_ViewController {
        let instance = DEBUG_ViewController()
        instance.inject(ui: .init())
        instance.title = "DEBUG"
        return instance
    }

    static func joke() -> JokeRandomViewController {
        let instance = JokeRandomViewController()
        instance.inject(viewModel: .init(), ui: .init())
        instance.title = "API"
        return instance
    }

    static func jokeSlack() -> JokeSlackViewController {
        let instance = JokeSlackViewController()
        instance.inject(viewModel: .init(), ui: .init())
        instance.title = "Joke Slack"
        return instance
    }

    static func coreData() -> CoreDataViewController {
        let instance = CoreDataViewController()
        instance.inject(viewModel: .init(), ui: .init())
        instance.title = "CoreData"
        return instance
    }

    struct Combine {
        static func just() -> JustViewController {
            let instance = JustViewController()
            instance.inject(viewModel: .init())
            instance.title = "Just"
            return instance
        }

        static func subject() -> SubjectViewController {
            let instance = SubjectViewController()
            instance.inject(viewModel: .init())
            instance.title = "Subject"
            return instance
        }

        static func future() -> FutureViewController {
            let instance = FutureViewController()
            instance.inject(viewModel: .init(), ui: .init())
            instance.title = "Future"
            return instance
        }

        static func deferred() -> DeferredViewController {
            let instance = DeferredViewController()
            instance.inject(viewModel: .init(), ui: .init())
            instance.title = "Deferred"
            return instance
        }
    }
}
