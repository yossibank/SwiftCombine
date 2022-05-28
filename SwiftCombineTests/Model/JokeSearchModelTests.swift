@testable import SwiftCombine
import XCTest

final class JokeSearchModelTests: XCTestCase {
    func testJokeSearchModel() throws {
        let result = try awaitPublisher(
            Domain.Usecase.Joke.Search(useTestData: true).fetch(parameters: .init())
        )
        let expect = try TestDataFetchRequest(
            testDataJsonPath: JokeSearchRequest(
                parameters: .init()
            ).testDataPath
        )
        .fetchLocalTestData(responseType: JokeSearchResponse.self)
        .map(JokeSearchMapper().convert)
        .get()

        XCTAssertEqual(result, expect)
    }
}
