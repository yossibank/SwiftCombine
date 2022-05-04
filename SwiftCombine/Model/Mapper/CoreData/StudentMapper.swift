struct StudentMapper {
    func convert(response: Student) -> StudentEntity {
        .init(
            name: response.name,
            age: Int(response.age),
            number: Int(response.number)
        )
    }
}
