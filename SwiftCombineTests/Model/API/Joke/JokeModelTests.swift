@testable import SwiftCombine
import XCTest

final class JokeModelTests: XCTestCase {
    func testJokeModel() throws {
        let result = try awaitPublisher(
            JokeModel(jokeId: "R7UfaahVfFd", useTestData: true).fetch()
        )
        let expect = try TestDataFetchRequest(
            testDataJsonPath: JokeRequest(
                pathComponent: "R7UfaahVfFd"
            ).testDataPath
        )
        .fetchLocalTestData(responseType: JokeResponse.self)
        .map(JokeMapper().convert)
        .get()

        XCTAssertEqual(result, expect)
    }
}
