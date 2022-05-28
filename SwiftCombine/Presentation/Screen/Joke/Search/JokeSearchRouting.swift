import UIKit

final class JokeSearchRouting: Routing {
    weak var viewController: UIViewController!
}

extension JokeSearchRouting {
    func showJokeGetScreen(jokeId: String) {
        let vc = AppControllers.Joke.Get(jokeId: jokeId)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
