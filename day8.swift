import Foundation

// Structs, Part I

// struct Sport {
    // var name: String // properties
// }

// var tennis = Sport(name: "Tennis")
// print(tennis.name)

// tennis.name = "Lawn tennis"

// properties can have default values, too

// Computed properties
// 1. computed properties must ALWAYS return a value

struct Sport {
    var name: String
    var isOlympicSport: Bool

    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

let chessBoxing = Sport(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)

// Property observers
// must be used on vars, not lets

struct Progress {
    var task: String
    var amount: Int {
        didSet {
            // will print everytime 'amount' is set
            print("\(task) is now \(amount)% complete")
        }
    }

}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100

// methods

struct City {
    var population: Int

    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes()

// Mutating methods
// if a struct was created as a constant,
// then all of its properties are constants regardless
// of how they were created (e.g. var thing)

// prefix a method with 'mutating' to allow a struct to change a property

struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()
print(person.name)

// Properties and methods of strings
// a String is a struct, with methods and properties

let string = "Do or do not, there is no try."
print(string.count)
print(string.hasPrefix("Do"))
print(string.uppercased())
print(string.sorted())

// Properties and methods of arrays
// Arrays are also structs with properties and methods

var toys = ["Woody"]
print(toys.count)
toys.append("Buzz")
toys.index(of: "Buzz")
print(toys.sorted())
toys.remove(at: 0)
