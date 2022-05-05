@testable import SwiftCombine
import XCTest

final class ClubModelTests: XCTestCase {
    private var model: ClubModel!

    override func setUpWithError() throws {
        model = Model.CoreData.Club(useTestData: false)
    }

    func testFetchClubModel() throws {
        let result = try awaitPublisher(model.fetch())

        XCTAssertTrue(result.contains { $0.name == "サッカー部" })
        XCTAssertEqual(result.count, 3)
    }
}
