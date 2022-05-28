@testable import SwiftCombine
import XCTest

final class FruitModelTests: XCTestCase {
    private var model: FruitUsecase!

    override func setUpWithError() throws {
        model = Domain.Usecase.CoreData.Fruit()
    }

    override func tearDown() {
        let object: Fruit = .init()
        CoreDataManager.shared.deleteObject(object)
    }

    func testAddFruitModel() throws {
        model.add(.init(name: "Apple"))
        model.add(.init(name: "Lemon"))
        model.add(.init(name: "Peach"))

        let result = try awaitPublisher(model.fetch())

        XCTAssertTrue(result.contains { $0.name == "Apple" })
        XCTAssertEqual(result.count, 3)
    }

    func testDeleteFuritModel() throws {
        model.add(.init(name: "Apple"))
        model.add(.init(name: "Lemon"))
        model.add(.init(name: "Peach"))

        let predicate = NSPredicate(format: "%K = %@", "name", "Apple")
        model.delete(predicate: [predicate])

        let result = try awaitPublisher(model.fetch())

        XCTAssertFalse(result.contains { $0.name == "Apple" })
        XCTAssertEqual(result.count, 2)
    }
}
