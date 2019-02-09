import Foundation

// Closures part II

// closures with parameters

// closures have the following general form
// { (parameters) -> return type in
//     statements
// }

func travel(action: (String) -> Void) {
    print("I'm getting ready to go")
    action("London") //  pass String to closure
    print("I arrived!")
}

// closure has 'place' as internal label
travel { (place: String) in
    print("I'm going to \(place) in my car")
}

// Using closures as parameters when they return values

func travel(action: (String) -> String) {
    print("I'm getting ready to go")
    let description = action("London")
    print(description)
    print("I've arrived!")
}

travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

// Shorthand parameter names

// we can remove the :String parameter because Swift infers it.
travel { place -> String in 
    return "I'm going to \(place) in my car"
}

// It also knows we are returning a String, so we can remove that too
travel { place in 
    return "I'm going to \(place) in my car"
}

// we can remove 'return' since it's the only line of code that could return
travel { place in 
    "I'm going to \(place) in my car"
}

// we can remove 'place in' as Swift provides an automatic name for closure parameters
// with a $ sign and a number starting with 0
travel { 
    "I'm going to \($0) in my car"
}
 
// Closures with multiple parameters

func travel(action: (String, Int) -> String) {
    print("I'm getting ready to go")
    let description = action("London", 60)
    print(description)
    print("I've arrived!")
}

travel {
    "I'm going to \($0) at \($1) miles per hour"
}

// Returning closures from functions

func travel() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

let result = travel()
result("London")

// doable, but not recommended format
let result2 = travel()("London") 

// Capturing values

func travel() -> (String) -> Void {
    var counter = 1
    return {
        print("I'm going to \($0)")
        counter += 1
    }
}

let result = travel()
result("London")
result("London")
result("London")
