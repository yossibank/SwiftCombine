@testable import SwiftCombine
import XCTest

final class StudentModelTests: XCTestCase {
    private var model: StudentModel!

    override func setUpWithError() throws {
        model = Model.CoreData.Student()
    }

    override func tearDown() {
        let object: Student = .init()
        CoreDataManager.shared.deleteObject(object)
    }

    func testAddStudentModel() throws {
        model.add(.init(name: "name1", age: 20, number: 0))
        model.add(.init(name: "name2", age: 25, number: 1))
        model.add(.init(name: "name3", age: 30, number: 2))

        let result = try awaitPublisher(model.fetch())

        XCTAssertTrue(result.contains { $0.name == "name1" })
        XCTAssertEqual(result.count, 3)
    }

    func testDeleteStudentModel() throws {
        model.add(.init(name: "name1", age: 20, number: 0))
        model.add(.init(name: "name2", age: 25, number: 1))
        model.add(.init(name: "name3", age: 30, number: 2))

        let predicate = NSPredicate(format: "%K = %@", "name", "name1")
        model.delete(predicate: [predicate])

        let result = try awaitPublisher(model.fetch())

        XCTAssertFalse(result.contains { $0.name == "name1" })
        XCTAssertEqual(result.count, 2)
    }
}
