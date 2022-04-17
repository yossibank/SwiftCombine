import UIKit

protocol UserInterface {
    func setupNavigationBar(
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem?
    )
    func setupView(rootView: UIView)
}

extension UserInterface {

    func setupNavigationBar(
        navigationBar: UINavigationBar? = nil,
        navigationItem: UINavigationItem? = nil
    ) {
        setupNavigationBar(
            navigationBar: navigationBar,
            navigationItem: navigationItem
        )
    }
}

final class NoUserInterface: UserInterface {

    func setupNavigationBar(
        navigationBar _: UINavigationBar?,
        navigationItem _: UINavigationItem?
    ) {
        assertionFailure("no need to implement")
    }

    func setupView(rootView _: UIView) {
        assertionFailure("no need to implement")
    }
}
