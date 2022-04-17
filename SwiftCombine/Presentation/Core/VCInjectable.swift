import UIKit

protocol VCInjectable: UIViewController {
    associatedtype VM: ViewModel
    associatedtype UI: UserInterface

    var viewModel: VM! { get set }
    var ui: UI! { get set }

    func inject(
        viewModel: VM,
        ui: UI
    )
}

extension VCInjectable {

    func inject(
        viewModel: VM,
        ui: UI
    ) {
        self.viewModel = viewModel
        self.ui = ui
    }
}

extension VCInjectable where VM == NoViewModel {

    func inject(ui: UI) {
        viewModel = VM()
        self.ui = ui
    }
}

extension VCInjectable where UI == NoUserInterface {

    func inject(viewModel: VM) {
        self.viewModel = viewModel
        ui = UI()
    }
}

extension VCInjectable where VM == NoViewModel, UI == NoUserInterface {

    func inject() {
        viewModel = VM()
        ui = UI()
    }
}
