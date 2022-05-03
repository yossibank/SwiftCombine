@testable import SwiftCombine
import XCTest

final class JokeRandomViewModelTests: XCTestCase {
    private var viewModel: JokeRandomViewModel!

    override func setUpWithError() throws {
        viewModel = JokeRandomViewModel(model: Model.Joke.Random(useTestData: true))
    }

    func testFetch() throws {
        let publisher = viewModel.$state.collect(1).first()

        viewModel.fetch()

        let result = try awaitPublisher(publisher)

        let expectation = try TestDataFetchRequest(
            testDataJsonPath: JokeRandomRequest(
                parameters: .init(),
                pathComponent: .init()
            ).testDataPath
        )
        .fetchLocalTestData(responseType: JokeResponse.self)
        .map(JokeMapper().convert)
        .get()

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first, .done(expectation))
    }
}
