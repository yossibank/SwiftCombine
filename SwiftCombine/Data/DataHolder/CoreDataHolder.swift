enum CoreDataHolder {
    @FetchCoreData(
        sortDescriptors: [],
        predicate: nil,
        fetchLimit: 0
    )
    static var fruits: [Fruit]

    @FetchCoreData(
        sortDescriptors: [],
        predicate: nil,
        fetchLimit: 0
    )
    static var students: [Student]

    @FetchCoreData(
        sortDescriptors: [.init(keyPath: \Club.name, ascending: true)],
        predicate: nil,
        fetchLimit: 0
    )
    static var clubs: [Club]
}
