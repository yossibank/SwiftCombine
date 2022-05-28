import UIKit

protocol VCInjectable: UIViewController {
    associatedtype VM: ViewModel
    associatedtype UI: UserInterface
    associatedtype R: Routing

    var viewModel: VM! { get set }
    var ui: UI! { get set }
    var routing: R! { get set }

    func inject(
        viewModel: VM,
        ui: UI,
        routing: R
    )
}

extension VCInjectable {
    func inject(
        viewModel: VM,
        ui: UI,
        routing: R
    ) {
        self.viewModel = viewModel
        self.ui = ui
        self.routing = routing
    }
}

extension VCInjectable where VM == NoViewModel {
    func inject(ui: UI, routing: R) {
        viewModel = VM()
        self.ui = ui
        self.routing = routing
    }
}

extension VCInjectable where UI == NoUserInterface {
    func inject(viewModel: VM, routing: R) {
        self.viewModel = viewModel
        ui = UI()
        self.routing = routing
    }
}

extension VCInjectable where R == NoRouting {
    func inject(viewModel: VM, ui: UI) {
        self.viewModel = viewModel
        self.ui = ui
        routing = R()
    }
}


extension VCInjectable where VM == NoViewModel, UI == NoUserInterface {
    func inject(routing: R) {
        viewModel = VM()
        ui = UI()
        self.routing = routing
    }
}

extension VCInjectable where VM == NoViewModel, R == NoRouting {
    func inject(ui: UI) {
        viewModel = VM()
        self.ui = ui
        routing = R()
    }
}

extension VCInjectable where UI == NoUserInterface, R == NoRouting {
    func inject(viewModel: VM) {
        self.viewModel = viewModel
        ui = UI()
        routing = R()
    }
}

extension VCInjectable where VM == NoViewModel, UI == NoUserInterface, R == NoRouting {
    func inject() {
        viewModel = VM()
        ui = UI()
        routing = R()
    }
}
