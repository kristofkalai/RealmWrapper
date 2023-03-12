# RealmWrapper
A wrapper around Realm! 🎁

## Setup

Add the following to `Package.swift`:

```swift
.package(url: "https://github.com/stateman92/RealmWrapper", exact: .init(0, 0, 3))
```

[Or add the package in Xcode.](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)

## Usage

```swift
let realm = RealmWrapper()
realm.add(Animal(name: "Tom", age: 3))
// realm.objects(Animal.self)?.count == 1
```

For details see the Example app.

## Tests

The library is well-tested with practically 100% coverage (84.5%).
