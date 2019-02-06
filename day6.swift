import Foundation

// Closures

let driving = {
    print("I'm driving in my car")
}
driving()

// accepting parameters

// let driving = { (place: String) in
    // print("I'm driving to \(place) in my car")
// }

// driving("London")

// returning values

let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

let message = drivingWithReturn("London")
print(message)

// Closures as parameters

// () -> Void // accepts no parameters and returns nothing
func travel(action: () -> Void) {
    print("I'm getting ready to go")
    action() // the closure you passed in
    print("I arrived!")
}

// use the driving closure from earlier
travel(action: driving)

// trailing closure syntax
travel() {
    print("I'm driving in my car")
}

travel {
    print("I'm driving in my car")
}
