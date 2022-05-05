@testable import SwiftCombine
import XCTest

final class ClubViewModelTests: XCTestCase {
    private var viewModel: ClubViewModel!

    override func setUpWithError() throws {
        viewModel = ClubViewModel(model: Model.CoreData.Club(useTestData: false))
    }

    func testFetch() throws {
        let publisher = viewModel.$state.collect(1).first()

        viewModel.fetch()

        let result = try awaitPublisher(publisher)
        let expectation = [
            ClubEntity(name: "サッカー部", money: 30000, place: "グラウンド", schedule: "火水木"),
            ClubEntity(name: "野球部", money: 10000, place: "公園", schedule: "月金土"),
            ClubEntity(name: "体操部", money: 8000, place: "講堂", schedule: "土日")
        ]

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first, .done(expectation))
    }
}
