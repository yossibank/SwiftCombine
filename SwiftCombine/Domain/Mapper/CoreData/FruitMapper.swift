struct FruitMapper {
    func convert(response: Fruit) -> FruitEntity {
        .init(name: response.name)
    }
}
