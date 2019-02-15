import Foundation

// review, day one

// Variables

var name = "Tim McGraw"
name = "Romeo"

// Types of Data

var name: String
name = "Tim McGraw"

var age: Int
age = 25

var latitude: Double
latitude = 36.166667

var longitude: Double // Double the accuracy of Float
longitude = -86.783333

var stayOutTooLate: Bool
stayOutTooLate = true

var nothingInBrain: Bool
nothingInBrain = true

var missABeat = false

// Type inference
var name = "Tim McGraw"
let age = 25
let longitude = -86.7833333
var nothingInBrain = true

// Operators

var a = 10
a = a + 1
a = a - 1
a = a * a

var b = 10
b += 10
b -= 10

var a = 1.1
var b = 2.2
var c = a + b

var name1 = "Tim McGraw"
var name2 = "Romeo"
var both = name1 + " and " name2

c > 3 // true
c >= 3 // true
c > 4 // false
c < 4 // true

var name = "Tim McGraw"
name == "Tim McGraw" // true (case sensitive)

var stayOutTooLate = true
stayOutTooLate // true
!stayOutTooLate // false

// String Interpolation
var name = "Tim McGraw"
"Your name is \(name)" // Your name is Tim McGraw

var age = 25
var latitude = 36.1666667

"Your name is \(name), your age is \(age), and your latitude is \(latitude)."

"Your age is \(age) years old. In another \(age) years you will be \(age * 2)."

// Arrays
var evenNumbers = [2, 4, 6, 8]
var songs: [Any] = ["Shake it Off", "You Belong with Me", "Back to December", 3]

songs[0]
songs[1]
songs[2] 

type(of: songs) // Array<String>.Type


// Dictionaries

var person = [
        "first"     :"Taylor", 
        "middle"    :"Allison", 
        "last"      :"Swift", 
        "month"     :"December", 
        "website"   :"taylorswift.com"
        ]
person["middle"]
person["month"]

// Conditional statements

var action: String
var person = "hater"

if person == "hater" {
    action = "hate"
} else if person == "player" {
    action = "play"
} else {
    action = "cruise"
}

var action: String
var stayOutTooLate = true
var nothingInBrain = true

if stayOutTooLate && nothingInBrain {
   action = "cruise" 
}

if !stayOutTooLate && !nothingInBrain {
    action = "cruise"
}

// Loops

print("1 x 10 is \(1 * 10)")
print("2 x 10 is \(2 * 10)")
print("3 x 10 is \(3 * 10)")
print("4 x 10 is \(4 * 10)")
print("5 x 10 is \(5 * 10)")
print("6 x 10 is \(6 * 10)")
print("7 x 10 is \(7 * 10)")
print("8 x 10 is \(8 * 10)")
print("9 x 10 is \(9 * 10)")
print("10 x 10 is \(10 * 10)")

for i inb 1...10 {
    print("\(i) x 10 is \(i * 10)")
}

var str = "Fakers gonna"

for _ in 1...5 {
    str += " fake"
}

print(str)

// 1..<5  // 1-4

var song = ["Shake it off", "You belong with me", "look what you made me do"]

for song in songs {
    print("my favorite song is \(song)")
}

var people ["players", "haters", "heart-breakers", "fakers"]
var action = ["play", "hate", "break", "fake"]

for i in 0...3 {
    print("\(people[i]) gonna \(action[i])")
}


for i in 0..<people.count {
    var str = "\(people[i]) gonna "

    for _ in 1...5 {
        str += " \(actions[i])"
    }

    print(str)
}

var counter = 0
while true {
    print("Counter is now \(counter)")

    counter += 1

    if counter == 556 {
        break
    }
}



var song = ["Shake it off", "You belong with me", "look what you made me do"]

for song in songs {

    if song == "You belong with me" {
        continue
    }

    print("My favorite song is \(song)") 
}


// Switch case

let liveAlbums = 2

switch liveAlbums {
    case 0...1:
    print("You're just starting out")

    case 2...3:
    print("You're a rising star!")

    case 4...5:
    print("You're world famous!")

    default:
    print("Have you done something new?")
}

