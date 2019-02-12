import Foundation

// Optionals

// 1. Handling missing data

var age: Int? = nil

// an optional can have a value or nil
// a question mark denotes an optional

age = 38

// unwrapping optionals

var name: String? = nil

if let unwrapped = name {
    print("\(unwrapped.count") letters")
} else {
    print("Missing name.")
}

// unwrapping with guard
// the guard statement allows your new constant to exist
// throughout the rest of your function. 'if let' does not
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }

    print("Hello, \(unwrapped)!")
}

// Force unwrapping.

let str = "5"
let num = Int(str)

// you can be sure that 'str' has a value here because it's right there
// in the code above it, so it's reasonably safe to force unwrap 
// it using the '!' operator (or crash operator)

let num = Int(str)!

// implicitly unwrapped optionals
// created because you know the variable will have a value
// by the time you use it.

let age: Int! = nil // implicitly unwrapped

// 6. Nil coalescing
// if nothing found in optional, then  a default is used

func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

let user = username(for: 15) ?? "Anonymous"

// Optional chaining

let names = ["John", "Paul", "George", "Ringo"]
let beatles = names.first?.uppercased()

// beatles will be set to nil if 'first' returns nil. 

// optional try

enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}

do {
    try checkPassword("password")
    print("Thhat password is good!")
} catch {
    print("You can't use that password.")
}

if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}

try! checkPassword("sekrit")
print("OK!")

//  9. Failable initializers
let str = "5"
let num = Int(str) // <-- failable initializer

struct Person {
    var id: String
    
    init?(id: String) { // will return an optional
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

// 10. Typecasting

class Animal {}
class Fish: Animal {}
class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}

let pets = [Fish(), Dog(), Fish(), Dog()]

for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}