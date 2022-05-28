import Combine

extension UsecaseImpl where R == Repos.Local.ClubCoreData, M == ClubMapper {
    func fetch() -> AnyPublisher<[ClubEntity], CoreDataError> {
        toPublisher { promise in
            repository.fetch() { result in
                switch result {
                case let .success(response):
                    let entities = response.map(mapper.convert)
                    promise(.success(entities))

                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }

    func mock() {
        let club1 = repository.object()
        club1.configure(.init(
            name: "サッカー部",
            money: 30000,
            place: "グラウンド",
            schedule: "火水木",
            students: []
        ))
        repository.add(club1)

        let club2 = repository.object()
        club2.configure(.init(
            name: "野球部",
            money: 10000,
            place: "公園",
            schedule: "月金土",
            students: []
        ))
        repository.add(club2)

        let club3 = repository.object()
        club3.configure(.init(
            name: "体操部",
            money: 8000,
            place: "講堂",
            schedule: "土日",
            students: []
        ))
        repository.add(club3)
    }
}