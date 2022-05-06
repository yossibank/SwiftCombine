import Combine

extension ModelImpl where R == Repos.Local.ClubCoreData, M == ClubMapper {
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
        club1.name = "サッカー部"
        club1.money = 30000
        club1.place = "グラウンド"
        club1.schedule = "火水木"
        repository.add(club1)

        let club2 = repository.object()
        club2.name = "野球部"
        club2.money = 10000
        club2.place = "公園"
        club2.schedule = "月金土"
        repository.add(club2)

        let club3 = repository.object()
        club3.name = "体操部"
        club3.money = 8000
        club3.place = "講堂"
        club3.schedule = "土日"
        repository.add(club3)
    }
}
