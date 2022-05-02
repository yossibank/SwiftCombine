struct FruitMapper {
    func convert(response: [Fruit]) -> [FruitEntity] {
        response.map {
            .init(name: $0.name)
        }
    }
}
