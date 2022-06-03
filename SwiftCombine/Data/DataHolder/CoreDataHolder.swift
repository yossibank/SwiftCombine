enum CoreDataHolder {
    @CoreDataStorage(
        sortDescriptors: [],
        predicate: nil
    )
    static var fruits: [Fruit]

    @CoreDataStorage(
        sortDescriptors: [],
        predicate: nil
    )
    static var students: [Student]

    @CoreDataStorage(
        sortDescriptors: [.init(keyPath: \Club.name, ascending: true)],
        predicate: nil
    )
    static var clubs: [Club]
}
