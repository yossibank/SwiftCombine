@testable import SwiftCombine
import XCTest

final class StudentModelTests: XCTestCase {
    private var usecase: StudentUsecase!

    override func setUpWithError() throws {
        usecase = Domain.Usecase.CoreData.Student()
    }

    override func tearDown() {
        let object: Student = .init()
        CoreDataManager.shared.deleteObject(object)
    }

    func testAddStudentModel() throws {
        usecase.add(.init(name: "name1", age: 20, number: 0))
        usecase.add(.init(name: "name2", age: 25, number: 1))
        usecase.add(.init(name: "name3", age: 30, number: 2))

        let result = try awaitPublisher(usecase.fetch())

        XCTAssertTrue(result.contains { $0.name == "name1" })
        XCTAssertEqual(result.count, 3)
    }

    func testDeleteStudentModel() throws {
        usecase.add(.init(name: "name1", age: 20, number: 0))
        usecase.add(.init(name: "name2", age: 25, number: 1))
        usecase.add(.init(name: "name3", age: 30, number: 2))

        let predicate = NSPredicate(format: "%K = %@", "name", "name1")
        usecase.delete(predicate: [predicate])

        let result = try awaitPublisher(usecase.fetch())

        XCTAssertFalse(result.contains { $0.name == "name1" })
        XCTAssertEqual(result.count, 2)
    }
}
