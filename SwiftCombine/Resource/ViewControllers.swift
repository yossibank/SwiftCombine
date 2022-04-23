import UIKit

struct AppControllers {
    static func api() -> APIViewController {
        let instance = APIViewController()
        instance.inject(viewModel: .init(), ui: .init())
        instance.title = "API"
        return instance
    }

    static func debug() -> DEBUG_ViewController {
        let instance = DEBUG_ViewController()
        instance.inject(ui: .init())
        instance.title = "DEBUG"
        return instance
    }

    static func future() -> FutureViewController {
        let instance = FutureViewController()
        instance.inject(viewModel: .init(), ui: .init())
        instance.title = "Future"
        return instance
    }

    static func home() -> HomeViewController {
        let instance = HomeViewController()
        instance.inject(viewModel: .init(), ui: .init())
        instance.title = "Home"
        return instance
    }
}
