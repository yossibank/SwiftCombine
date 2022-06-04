@testable import SwiftCombine
import XCTest

final class MapperTests: XCTestCase {
    func testJokeMapper() {
        let result = JokeMapper().convert(
            response: .init(
                id: "M7wPC5wPKBd",
                joke: "Did you hear the one about the guy with the broken hearing aid? Neither did he.",
                status: 200
            )
        )

        let expect: JokeEntity = .init(
            id: "M7wPC5wPKBd",
            joke: "Did you hear the one about the guy with the broken hearing aid? Neither did he.",
            status: 200
        )

        XCTAssertEqual(result, expect)
    }

    func testJokeSearchMapper() {
        let result = JokeSearchMapper().convert(
            response: .init(
                currentPage: 1,
                limit: 20,
                nextPage: 2,
                previousPage: 1,
                results: [
                    .init(
                        id: "M7wPC5wPKBd",
                        joke: "Did you hear the one about the guy with the broken hearing aid? Neither did he."
                    )
                ],
                searchTerm: "",
                status: 200,
                totalJokes: 307,
                totalPages: 15
            )
        )

        let expect: JokeSearchEntity = .init(
            currentPage: 1,
            limit: 20,
            nextPage: 2,
            previousPage: 1,
            results: [
                .init(
                    id: "M7wPC5wPKBd",
                    joke: "Did you hear the one about the guy with the broken hearing aid? Neither did he."
                )
            ],
            searchTerm: "",
            status: 200,
            totalJokes: 307,
            totalPages: 15
        )

        XCTAssertEqual(result, expect)
    }

    func testJokeSlackMapper() {
        let result = JokeSlackMapper().convert(
            response: .init(
                attachments: [
                    .init(
                        fallback: "fallback",
                        footer: "footer",
                        text: "text"
                    )
                ],
                responseType: "response_type",
                username: "username"
            )
        )

        let expect: JokeSlackEntity = .init(
            attachments: [
                .init(
                    fallback: "fallback",
                    footer: "footer",
                    text: "text"
                )
            ],
            responseType: "response_type",
            username: "username"
        )

        XCTAssertEqual(result, expect)
    }
}
