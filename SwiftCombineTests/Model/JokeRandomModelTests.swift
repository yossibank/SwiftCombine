@testable import SwiftCombine
import XCTest

final class JokeRandomModelTests: XCTestCase {
    func testJokeRandomModel() throws {
        let result = try awaitPublisher(
            Model.Joke.Random(useTestData: true).fetch()
        )
        let expect = try TestDataFetchRequest(
            testDataJsonPath: JokeRandomGetRequest().testDataPath
        )
        .fetchLocalTestData(responseType: JokeRandomResponse.self)
        .map(JokeMapper().convert)
        .get()

        XCTAssertEqual(result, expect)
    }
}
