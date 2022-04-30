@testable import SwiftCombine
import XCTest

final class JokeViewModelTests: XCTestCase {
    private var viewModel: JokeViewModel!

    override func setUpWithError() throws {
        viewModel = JokeViewModel(model: Model.Joke(useTestData: true))
    }

    func testFetch() throws {
        let publisher = viewModel.$state.collect(1).first()

        viewModel.fetch()

        let result = try awaitPublisher(publisher)

        let expectation = try TestDataFetchRequest(
            testDataJsonPath: JokeGetRequest(
                parameters: .init(),
                pathComponent: .init()
            ).testDataPath
        )
        .fetchLocalTestData(responseType: JokeResponse.self)
        .get()

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first, .done(expectation))
    }
}
