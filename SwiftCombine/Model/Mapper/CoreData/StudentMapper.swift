struct StudentMapper {
    func convert(response: Student) -> StudentEntity {
        .init(
            name: response.name,
            age: Int(response.age),
            number: Int(response.number),
            club: convert(response: response.club)
        )
    }

    private func convert(response: Club?) -> ClubEntity? {
        guard let response = response else {
            return nil
        }

        return .init(
            name: response.name,
            money: Int(response.money),
            place: response.place,
            schedule: response.schedule,
            students: []
        )
    }
}
