@testable import SwiftCombine
import XCTest

final class JokeModelTests: XCTestCase {
    func testJokeModel() throws {
        let result = try awaitPublisher(
            Model.Joke(useTestData: true).fetch()
        )
        let expect = try TestDataFetchRequest(
            testDataJsonPath: JokeGetRequest().testDataPath
        )
        .fetchLocalTestData(responseType: JokeResponse.self)
        .get()

        XCTAssertEqual(result, expect)
    }
}
