//
//  Animal.swift
//
//
//  Created by Kristóf Kálai on 2023. 02. 26..
//

import Foundation
import RealmSwift

final class Animal: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted private(set) var name: String
    @Persisted private var age: Int

    init(id: UUID = .init(), name: String, age: Int) {
        super.init()
        self.id = id.uuidString
        self.name = name
        self.age = age
    }

    override init() {
        super.init()
        id = .init()
        name = .init()
        age = .init()
    }

    override class func primaryKey() -> String? {
        "id"
    }
}
