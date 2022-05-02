@testable import SwiftCombine
import XCTest

final class FruitModelTests: XCTestCase {
    private var model: FruitModel!

    override func setUpWithError() throws {
        model = Model.CoreData.Fruit(useTestData: true)
    }

    func testFruitModel() throws {
        model.add(.init(name: "Apple"))
        model.add(.init(name: "Lemon"))

        let result = try awaitPublisher(model.fetchAll())
        XCTAssertEqual(result.count, 2)
    }
}
