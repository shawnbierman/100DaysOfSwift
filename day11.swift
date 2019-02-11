import Foundation

// Protocols and Extensions

// protocols are way of describing what properties and methods a thing must have.

protocol Identifiable {
    var id: String { get set }
}

struct User: Identifiable {
    var id: String
}

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

// protocol inheritance:  one protocol can inherit multiple other protocols

protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study() -> Int
}

protocol HasVacation {
    func takeVacation() -> Int
}

// extensions: add methods to existing types

extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number = 8
number.squared()

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

// protocol extensions

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = set(["John", "Paul", "George", "Ringo"])

extension Collection {
    func summarize() {
        print("There are \(count) of us:")
    }

    for name in self {
        print(name)
    }
}

pythons.summarize()
beatles.summarize()

// protocol-oriented programming


protocol Identifiable {
    var id: String { get set }
    func identify() 
}

extension Identifiable {
    func identify() {
        print("My ID is \(id)")
    }
}

let twostraws = User(id: "twostraws")
twostraws.identify()

