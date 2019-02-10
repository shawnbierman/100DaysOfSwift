import Foundation

// Classes and Inheritance

// classes:
// similar to structs, but...
// 1. do not come with a memberwise initializer, you must create your own

class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let poppy = Dog(name: "Poppy", breed: "Poodle")

// 2. create a class based on a different class (inheritance or subclassing)

class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}

// overriding methods

class Dog {
    func makeNoise() {
        print("Woof!")
    }
}

class Poodle: Dog {
    override func makeNoise() {
        print("Yip!")
    }
}

let poppy = Poodle()
poppy.makeNoise()

// 'Final' classes
// no other class can inherit from it.

final class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

// Copying objects
// 3. difference between classes and structs and how they are copied
// classes are copied, but with structs they are different objects

class Singer {
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name ) // prints Taylor Swift

var singerCopy = singer // just a pointer back to singer
singerCopy.name = "Justin Bieber"

print(singer.name) // prints Justin Bieber

// ---

struct Singer {
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name) // prints Taylor Swift

var singerCopy = singer // a new object, not a pointer (copy)
singerCopy.name = "Justin Bierber"

print(singer.name) // prints Taylor Swift

// Deinitializers
// 4. classes can have deinitializers(), run when class destroyed.

class Person {
    var name = "John Doe"

    init() {
        print("\(name) is alive!")
    }

    func printGreeting() {
        print("Hello, I'm (\(name)")
    }
    deinit {
        print("\(name) is no more!")
    }
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}

// Mutability
// 5. the way classes and structs deal with constants

class Singer {
    var name = "Taylor Swift"
}

let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)

// if the 'name' property were a 'let' constant, you wouldn't be able to
// change it. 

