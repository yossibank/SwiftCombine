import UIKit

final class DEBUG_Routing: Routing {
    weak var viewController: UIViewController!
}

extension DEBUG_Routing {
    func showJokeScreen(item: DEBUG_API) {
        switch item {
        case .get:
            let vc = AppControllers.Joke.Get(jokeId: AppDataHolder.jokeId)
            viewController.navigationController?.pushViewController(vc, animated: true)

        case .random:
            let vc = AppControllers.Joke.Random()
            viewController.navigationController?.pushViewController(vc, animated: true)

        case .search:
            let vc = AppControllers.Joke.Search()
            vc.delegate = self
            viewController.navigationController?.pushViewController(vc, animated: true)

        case .slack:
            let vc = AppControllers.Joke.Slack()
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func showCoreDataScreen(item: DEBUG_CoreData) {
        switch item {
        case .fruit:
            let vc = AppControllers.CoreData.Fruit()
            viewController.navigationController?.pushViewController(vc, animated: true)

        case .student:
            let vc = AppControllers.CoreData.Student()
            vc.delegate = self
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func showCombineScreen(item: DEBUG_Combine) {
        switch item {
        case .just:
            let vc = AppControllers.Combine.Just()
            viewController.navigationController?.pushViewController(vc, animated: true)

        case .subject:
            let vc = AppControllers.Combine.Subject()
            viewController.navigationController?.pushViewController(vc, animated: true)

        case .future:
            let vc = AppControllers.Combine.Future()
            viewController.navigationController?.pushViewController(vc, animated: true)

        case .deferred:
            let vc = AppControllers.Combine.Deferred()
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func showFileStorageScreen(item: DEBUG_FileStorage) {
        switch item {
        case .someFile:
            let vc = AppControllers.SomeFile()
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func update(_ type: UserDefaultEnumKey.ServerType) {
        (viewController.tabBarController as? TabBarController)?.configureTab(type)
    }
}

extension DEBUG_Routing: JokeSearchViewControllerDelegate {
    func showJokeGetScreen(jokeId: String) {
        let vc = AppControllers.Joke.Get(jokeId: jokeId)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DEBUG_Routing: StudentViewControllerDelegate {
    func showClubScreen() {
        let vc = AppControllers.CoreData.Club()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
