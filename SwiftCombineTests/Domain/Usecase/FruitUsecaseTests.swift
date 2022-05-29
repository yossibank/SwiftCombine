@testable import SwiftCombine
import XCTest

final class FruitModelTests: XCTestCase {
    private var usecase: FruitUsecase!

    override func setUpWithError() throws {
        usecase = Domain.Usecase.CoreData.Fruit()
    }

    override func tearDown() {
        CoreDataManager.shared.deleteObject(Fruit())
    }

    func testAddFruitModel() throws {
        usecase.add(.init(name: "Apple"))
        usecase.add(.init(name: "Lemon"))
        usecase.add(.init(name: "Peach"))

        let result = try awaitPublisher(usecase.fetch())

        XCTAssertTrue(result.contains { $0.name == "Apple" })
        XCTAssertEqual(result.count, 3)
    }

    func testDeleteFuritModel() throws {
        usecase.add(.init(name: "Apple"))
        usecase.add(.init(name: "Lemon"))
        usecase.add(.init(name: "Peach"))

        let predicate = NSPredicate(format: "%K = %@", "name", "Apple")
        usecase.delete(predicate: [predicate])

        let result = try awaitPublisher(usecase.fetch())

        XCTAssertFalse(result.contains { $0.name == "Apple" })
        XCTAssertEqual(result.count, 2)
    }
}
