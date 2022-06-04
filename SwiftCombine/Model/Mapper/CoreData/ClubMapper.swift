struct ClubMapper {
    func convert(response: Club) -> ClubEntity {
        .init(
            name: response.name,
            money: Int(response.money),
            place: response.place,
            schedule: response.schedule,
            students: response.students.map(convert)
        )
    }

    private func convert(response: Student) -> StudentEntity {
        .init(
            name: response.name,
            age: Int(response.age),
            number: Int(response.number)
        )
    }
}
