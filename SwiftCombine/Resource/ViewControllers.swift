import UIKit

struct AppControllers {
    static func Home() -> HomeViewController {
        let instance = HomeViewController()
        instance.inject(viewModel: .init(), ui: .init())
        instance.title = "Home"
        return instance
    }

    static func Debug() -> DEBUG_ViewController {
        let instance = DEBUG_ViewController()
        instance.inject(ui: .init())
        instance.title = "DEBUG"
        return instance
    }

    struct CoreData {
        static func Fruit() -> FruitViewController {
            let instance = FruitViewController()
            instance.inject(viewModel: .init(), ui: .init())
            instance.title = "Fruit"
            return instance
        }
    }

    struct Joke {
        static func Get() -> JokeGetViewController {
            let instance = JokeGetViewController()
            instance.inject(viewModel: .init(), ui: .init())
            instance.title = "Joke Get"
            return instance
        }

        static func Random() -> JokeRandomViewController {
            let instance = JokeRandomViewController()
            instance.inject(viewModel: .init(), ui: .init())
            instance.title = "Joke Random"
            return instance
        }

        static func Search() -> JokeSearchViewController {
            let instance = JokeSearchViewController()
            instance.inject(viewModel: .init(), ui: .init())
            instance.title = "Joke Search"
            return instance
        }

        static func Slack() -> JokeSlackViewController {
            let instance = JokeSlackViewController()
            instance.inject(viewModel: .init(), ui: .init())
            instance.title = "Joke Slack"
            return instance
        }
    }

    struct Combine {
        static func Just() -> JustViewController {
            let instance = JustViewController()
            instance.inject(viewModel: .init())
            instance.title = "Just"
            return instance
        }

        static func Subject() -> SubjectViewController {
            let instance = SubjectViewController()
            instance.inject(viewModel: .init())
            instance.title = "Subject"
            return instance
        }

        static func Future() -> FutureViewController {
            let instance = FutureViewController()
            instance.inject(viewModel: .init(), ui: .init())
            instance.title = "Future"
            return instance
        }

        static func Deferred() -> DeferredViewController {
            let instance = DeferredViewController()
            instance.inject(viewModel: .init(), ui: .init())
            instance.title = "Deferred"
            return instance
        }
    }
}
