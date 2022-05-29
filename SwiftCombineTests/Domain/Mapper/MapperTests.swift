@testable import SwiftCombine
import XCTest

final class MapperTests: XCTestCase {
    override func tearDown() {
        CoreDataManager.shared.deleteObject(Club())
        CoreDataManager.shared.deleteObject(Fruit())
        CoreDataManager.shared.deleteObject(Student())
    }

    func testClubMapper() {
        let club = CoreDataStorage<Club>().object()
        club.configure(.init(
            name: "soccer",
            money: 20000,
            place: "ground",
            schedule: "monday",
            students: []
        ))

        let result = ClubMapper().convert(
            response: club
        )

        let expect: ClubEntity = .init(
            name: "soccer",
            money: 20000,
            place: "ground",
            schedule: "monday",
            students: []
        )

        XCTAssertEqual(result, expect)
    }

    func testFruitMapper() {
        let fruit = CoreDataStorage<Fruit>().object()
        fruit.configure(.init(
            name: "Fruit"
        ))

        let result = FruitMapper().convert(
            response: fruit
        )

        let expect: FruitEntity = .init(name: "Fruit")

        XCTAssertEqual(result, expect)
    }

    func testStudentMapper() {
        let student = CoreDataStorage<Student>().object()
        student.configure(.init(
            name: "student",
            age: 20,
            number: 0
        ))

        let result = StudentMapper().convert(
            response: student
        )

        let expect: StudentEntity = .init(
            name: "student",
            age: 20,
            number: 0
        )

        XCTAssertEqual(result, expect)
    }

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
