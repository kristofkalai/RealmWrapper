import XCTest
import RealmSwift
@testable import RealmWrapper

final class RealmWrapperTests: XCTestCase {
    private lazy var realm = RealmWrapper(providedRealm: try! Realm())
    private lazy var object = Animal(name: "name", age: 12)

    override func setUp() {
        super.setUp()
        RealmWrapper.configureRealm()
        realm.deleteAll()
    }
}

extension RealmWrapperTests {
    func testAddObject() throws {
        realm.add(object)
        XCTAssertEqual(realm.objects(Animal.self)?.count, 1)
        XCTAssertEqual(realm.objects(Animal.self)?.first?.id, object.id)
        XCTAssertEqual(realm.object(Animal.self, key: object.id)?.id, object.id)
    }

    func testDeleteObject() throws {
        realm.add(object)
        XCTAssertEqual(realm.objects(Animal.self)?.count, 1)
        realm.delete(object)
        XCTAssertEqual(realm.objects(Animal.self)?.count, 0)
    }

    func testPredicate() throws {
        realm.add(object)
        XCTAssertEqual(realm.objects(Animal.self, predicate: .init(format: "%K = %@", "name", object.name))?.count, 1)
        realm.delete(object)
        XCTAssertEqual(realm.objects(Animal.self)?.count, 0)
    }

    func testTransaction() throws {
        realm.runTransaction { realm in
            realm.add(object)
            realm.cancelWrite()
        }
        XCTAssertEqual(realm.objects(Animal.self)?.count, 0)
    }
}
