struct ClubMapper {
    func convert(response: Club) -> ClubEntity {
        .init(
            name: response.name,
            money: Int(response.money),
            place: response.place,
            schedule: response.schedule
        )
    }
}
