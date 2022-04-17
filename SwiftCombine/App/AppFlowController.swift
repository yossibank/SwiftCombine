import UIKit

// MARK: - stored properties & init

final class AppFlowController: UIViewController {
    private let mainFlowController = MainFlowController()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - override methods

extension AppFlowController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        children.first?.view.frame = view.bounds
    }
}

// MARK: - protocol

extension AppFlowController: FlowController {
    func start() {
        removeFirstChild()
        add(mainFlowController)
        mainFlowController.start()
    }
}
