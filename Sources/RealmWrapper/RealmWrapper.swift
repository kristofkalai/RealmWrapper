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
        self.provide(realm: providedRealm)
    }
}

extension RealmWrapper {
    public func objects<T: Object>(_ type: T.Type, predicate: NSPredicate? = nil) -> Results<T>? {
        if let predicate {
            return realm?.objects(type).filter(predicate)
        }
        return realm?.objects(type)
    }

    public func object<T: Object>(_ type: T.Type, key: String) -> T? {
        realm?.object(ofType: type, forPrimaryKey: key)
    }

    @discardableResult public func add<T: Object>(_ data: [T], update: Realm.UpdatePolicy = .all) -> Bool {
        guard let realm else { return false }
        do {
            try realm.write {
                realm.add(data, update: update)
            }
            return true
        } catch {
            return false
        }
    }

    @discardableResult public func add<T: Object>(_ data: T, update: Realm.UpdatePolicy = .all) -> Bool {
        add([data], update: update)
    }

    @discardableResult public func runTransaction(action: (Realm) -> Void) -> Bool {
        guard let realm else { return false }
        do {
            try realm.write {
                action(realm)
            }
            return true
        } catch {
            return false
        }
    }

    @discardableResult public func delete<T: Object>(_ data: [T]) -> Bool {
        guard let realm else { return false }
        do {
            try realm.write {
                realm.delete(data)
            }
            return true
        } catch {
            return false
        }
    }

    @discardableResult public func delete<T: Object>(_ data: T) -> Bool {
        delete([data])
    }

    @discardableResult public func deleteAll() -> Bool {
        guard let realm else { return false }
        do {
            try realm.write {
                realm.deleteAll()
            }
            return true
        } catch {
            return false
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
