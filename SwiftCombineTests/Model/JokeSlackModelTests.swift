@testable import SwiftCombine
import XCTest

final class JokeSlackModelTests: XCTestCase {
    func testJokeSlackModel() throws {
        let result = try awaitPublisher(
            Model.Joke.Slack(useTestData: true).fetch()
        )
        let expect = try TestDataFetchRequest(
            testDataJsonPath: JokeSlackGetRequest().testDataPath
        )
        .fetchLocalTestData(responseType: JokeSlackResponse.self)
        .get()

        XCTAssertEqual(result, expect)
    }
}
