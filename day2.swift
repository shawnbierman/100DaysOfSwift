import Foundation

// Arrays

let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]
print(beatles[1])

// Sets - unordered and unique values

let colors = Set(["red", "green", "blue"])
let colors2 = Set(["red", "green", "blue", "red", "blue"])

// Tuples - fixed size

var name = (first: "Taylor", last: "Swift")
print(name.0)
print(name.first)

let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")
let set = Set(["aardvark", "astronaut", "azalea"])
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]

// Dictionaries

let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
print(heights["Taylor Swift"])

// Dictionary - default values

let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

print(favoriteIceCream["Paul"])
print(favoriteIceCream["Charlotte"])
print(favoriteIceCream["Charlotte", default: "Unknown"])

// Creating empty collections

var teams = [String: String]()
teams["Paul"] = "Red"

var results = [Int]()

var words = Set<String>()
var numbers = Set<Int>()

var scores = Dictionary<String, Int>()
var results = Array<Int>()

// Enumerations

let result = "failure"
let result2 = "failed"
let result3 = "fail"

enum Result {
    case success
    case failure
}

let result4 = Result.failure

// Enum associated values

enum Activity {
    case bored
    case running
    case talking
    case singing
}

enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "football")

// Enum raw values

enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
}

let earth = Planet(rawValue: 2)

enum Planet: Int {
    case mercury = 1 // Swift will starting counting up from here
    case venus
    case earth
    case mars
}