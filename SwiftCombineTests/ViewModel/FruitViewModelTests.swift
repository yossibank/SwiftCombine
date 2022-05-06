@testable import SwiftCombine
import XCTest

final class FruitViewModelTests: XCTestCase {
    private var viewModel: FruitViewModel!

    override func setUpWithError() throws {
        viewModel = FruitViewModel(model: Model.CoreData.Fruit())
    }

    func testAdd() throws {
        viewModel.addName = "Apple"
        viewModel.add()

        let publisher = viewModel.$state.collect(1).first()

        viewModel.fetch()

        let result = try awaitPublisher(publisher)
        let expectaion = [FruitEntity(name: "Apple")]

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first, .done(expectaion))
    }

    func testDelete() throws {
        viewModel.addName = "Apple"
        viewModel.add()

        viewModel.addName = "Lemon"
        viewModel.add()

        viewModel.deleteName = "Apple"
        viewModel.delete()

        let publisher = viewModel.$state.collect(1).first()

        viewModel.fetch()

        let result = try awaitPublisher(publisher)
        let expectaion = [FruitEntity(name: "Lemon")]

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first, .done(expectaion))
    }
}
