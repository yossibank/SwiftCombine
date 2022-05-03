@testable import SwiftCombine
import XCTest

final class JokeSlackModelTests: XCTestCase {
    func testJokeSlackModel() throws {
        let result = try awaitPublisher(
            Model.Joke.Slack(useTestData: true).fetch()
        )
        let expect = try TestDataFetchRequest(
            testDataJsonPath: JokeSlackRequest().testDataPath
        )
        .fetchLocalTestData(responseType: JokeSlackResponse.self)
        .map(JokeSlackMapper().convert)
        .get()

        XCTAssertEqual(result, expect)
    }
}
