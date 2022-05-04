@testable import SwiftCombine
import XCTest

final class JokeSearchViewModelTests: XCTestCase {
    private var viewModel: JokeSearchViewModel!

    override func setUpWithError() throws {
        viewModel = JokeSearchViewModel(model: Model.Joke.Search(useTestData: true))
    }

    func testFetch() throws {
        let publisher = viewModel.$state.collect(1).first()

        viewModel.fetch(isAdditional: false)

        let result = try awaitPublisher(publisher)

        let expectation = try TestDataFetchRequest(
            testDataJsonPath: JokeSearchRequest(
                parameters: .init(),
                pathComponent: .init()
            ).testDataPath
        )
        .fetchLocalTestData(responseType: JokeSearchResponse.self)
        .map(JokeSearchMapper().convert)
        .get()

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first, .done(expectation))
    }

    func testAdditionalFetch() throws {
        viewModel.fetch(isAdditional: false)
        XCTAssertEqual(viewModel.items.count, 3)

        viewModel.fetch(isAdditional: true)
        XCTAssertEqual(viewModel.items.count, 6)

        viewModel.fetch(isAdditional: true)
        XCTAssertEqual(viewModel.items.count, 9)
    }
}
