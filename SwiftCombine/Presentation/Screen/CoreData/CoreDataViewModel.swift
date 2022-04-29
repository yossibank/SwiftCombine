import CoreData
import Combine

final class CoreDataViewModel: ViewModel {
    @Published var name: String = ""
    @Published var items: [CoreDataItem] = []

    func fetch() {
        let list: [FruitEntity] = CoreDataRepository.array()
        items = list.map { .init(title: $0.name ?? "") }
    }

    func save() {
        let entity = FruitEntity.new(name: name)
        CoreDataRepository.add(entity)
        CoreDataRepository.save()
    }
}
