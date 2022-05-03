@testable import SwiftCombine
import XCTest

final class MapperTests: XCTestCase {
    func testFruitMapper() {
        let coreDataFruit: Fruit = CoreDataRepository(useTestData: true).create()
        coreDataFruit.name = "Fruit"

        let result = FruitMapper().convert(
            response: [coreDataFruit]
        )

        let expect: [FruitEntity] = [
            .init(name: "Fruit")
        ]

        XCTAssertEqual(result, expect)
    }

    func testJokeMapper() {
        let result = JokeMapper().convert(
            response: .init(
                id: "11111",
                joke: "joke joke",
                status: 200
            )
        )

        let expect: JokeEntity = .init(
            id: "11111",
            joke: "joke joke",
            status: 200
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
