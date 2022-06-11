enum FruitCoreDataHolder {
    @FetchCoreData(fetchLimit: 0)
    static var all: [Fruit]

    @FetchCoreData()
    static var specify: [Fruit]
}

enum StudentCoreDataHolder {
    @FetchCoreData(fetchLimit: 0)
    static var all: [Student]
}

enum ClubCoreDataHolder {
    @FetchCoreData(fetchLimit: 0)
    static var all: [Club]
}
