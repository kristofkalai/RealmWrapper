//
//  ContentView.swift
//  Example
//
//  Created by Kristóf Kálai on 2023. 03. 12..
//

import RealmSwift
import RealmWrapper
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .onAppear(perform: realmWrapperTestMethod)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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

private func realmWrapperTestMethod() {
    let realm = RealmWrapper()
    realm.deleteAll()
    realm.add(Animal(name: "Tom", age: 3))
    assert(realm.objects(Animal.self)?.count == 1)
}
