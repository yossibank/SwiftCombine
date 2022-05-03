@testable import SwiftCombine
import XCTest

final class JokeGetModelTests: XCTestCase {
    func testJokeGetModel() throws {
        let result = try awaitPublisher(
            Model.Joke.Get(useTestData: true).fetch(jokeId: "R7UfaahVfFd")
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
