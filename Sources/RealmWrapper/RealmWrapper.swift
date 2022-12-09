//
//  RealmWrapper.swift
//
//
//  Created by Kristof Kalai on 2022. 12. 09..
//

import Foundation
import RealmSwift

public struct RealmWrapper {
    private var providedRealm: Realm?

    public init(providedRealm: Realm? = nil) {
        self.providedRealm = providedRealm
    }

    public func objects<T: Object>(_ type: T.Type, predicate: NSPredicate? = nil) -> Results<T>? {
        if let predicate = predicate {
            return realm?.objects(type).filter(predicate)
        } else {
            return realm?.objects(type)
        }
    }

    public func object<T: Object>(_ type: T.Type, key: String) -> T? {
        realm?.object(ofType: type, forPrimaryKey: key)
    }

    public func add<T: Object>(_ data: [T], update: Realm.UpdatePolicy = .all) {
        guard let realm = realm else { return }
        try? realm.write {
            realm.add(data, update: update)
        }
    }

    public func add<T: Object>(_ data: T, update: Realm.UpdatePolicy = .all) {
        add([data], update: update)
    }

    public func runTransaction(action: () -> Void) {
        try? realm?.write {
            action()
        }
    }

    public func delete<T: Object>(_ data: [T]) {
        guard let realm = realm else { return }
        try? realm.write {
            realm.delete(data)
        }
    }

    public func delete<T: Object>(_ data: T) {
        delete([data])
    }

    public func deleteAll() {
        guard let realm = realm else { return }
        try? realm.write {
            realm.deleteAll()
        }
    }
}

extension RealmWrapper {
    public mutating func provide(realm: Realm?) {
        providedRealm = realm
    }

    private var realm: Realm? {
        providedRealm ?? (try? Realm())
    }
}

extension RealmWrapper {
    public static func configureRealm(deleteRealmIfMigrationNeeded flag: Bool = true) {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(deleteRealmIfMigrationNeeded: flag)
    }
}
