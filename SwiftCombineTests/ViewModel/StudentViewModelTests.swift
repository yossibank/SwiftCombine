@testable import SwiftCombine
import XCTest

final class StudentViewModelTests: XCTestCase {
    private var viewModel: StudentViewModel!

    override func setUpWithError() throws {
        viewModel = StudentViewModel(model: Model.CoreData.Student(useTestData: true))
    }

    func testAdd() throws {
        viewModel.name = "name1"
        viewModel.age = "20"
        viewModel.number = "0"
        viewModel.add()

        let publisher = viewModel.$state.collect(1).first()

        viewModel.fetch()

        let result = try awaitPublisher(publisher)
        let expectaion = [StudentEntity(name: "name1", age: 20, number: 0)]

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first, .done(expectaion))
    }

    func testDelete() throws {
        viewModel.name = "name1"
        viewModel.age = "20"
        viewModel.number = "0"
        viewModel.add()

        viewModel.name = "name2"
        viewModel.age = "25"
        viewModel.number = "1"
        viewModel.add()

        viewModel.delete(name: "name1")

        let publisher = viewModel.$state.collect(1).first()

        viewModel.fetch()

        let result = try awaitPublisher(publisher)
        let expectaion = [StudentEntity(name: "name2", age: 25, number: 1)]

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first, .done(expectaion))
    }
}
