@testable import SwiftCombine
import XCTest

final class JokeRandomModelTests: XCTestCase {
    func testJokeRandomModel() throws {
        let result = try awaitPublisher(
            Domain.Usecase.Joke.Random(useTestData: true).fetch()
        )
        let expect = try TestDataFetchRequest(
            testDataJsonPath: JokeRandomRequest().testDataPath
        )
        .fetchLocalTestData(responseType: JokeResponse.self)
        .map(JokeMapper().convert)
        .get()

        XCTAssertEqual(result, expect)
    }
}
