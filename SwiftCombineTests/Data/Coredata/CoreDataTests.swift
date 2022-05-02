@testable import SwiftCombine
import CoreData
import XCTest

final class CoreDataTests: XCTestCase {
    var managedObjectContext: NSManagedObjectContext?

    override func setUp() {
        super.setUp()

        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])
        let storeCoordinator = NSPersistentStoreCoordinator(
            managedObjectModel: managedObjectModel!
        ) as NSPersistentStoreCoordinator

        do {
            try storeCoordinator.addPersistentStore(
                ofType: NSInMemoryStoreType,
                configurationName: nil,
                at: nil
            )
        } catch {
            Logger.error(message: error.localizedDescription)
            abort()
        }

        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext!.persistentStoreCoordinator = storeCoordinator
    }

    func testFuritExists() {
        let entity = NSEntityDescription.entity(forEntityName: "Fruit", in: managedObjectContext!)
        let model = Fruit(entity: entity!, insertInto: managedObjectContext!)
        XCTAssertNotNil(model)
    }
}
