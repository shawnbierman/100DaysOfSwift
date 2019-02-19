// day 14 - review, day two.
// functions

import Foundation

func favoriteAlbum(name: String) {
    print("My favorite is \(name)")
}

favoriteAlbum(name: "Fearless")


func printAlbumRelease(name: String, year: Int) {
    print("\(name) was released in \(year)")
}

printAlbumRelease(name: "Fearless", year: 2008)


func countLetters(in string: String) {
    print("The string \(string) has \(string.count)")
}

countLetters(in: "Hello")

func albumIsTaylors(name: String) -> Bool {
    if name == "Taylor Swift" { return true }
    if name == "Fearless" { return true }
    return false
}

if albumIsTaylors(name: "Taylor Swift") {
    print("That's one of hers!")
} else {
    print("Who made that?")
}

if albumIsTaylors(name: "The White Album") {
    print("That's one of hers!")
} else {
    print("Who made that?")
}


// Optionals

func getHatersStatus(weather: String) -> String? {
    if weather == "Sunny" {
        return nil
    }  else {
        return "Hate"
    }
}

var status: String?
status = getHatersStatus(weather: "rainy")

if let unwrappedStatus = status {
    // unwrappedStatus contains a non-optional string
} else {
    // in case you want an else black, here you go....
}

func takeHaterAction(status: String) { // requires a String
    if status == "Hate" {
        print("Hating")
    }
}

if let haterStatus = getHaterStatus(weather: "rainy") {
    takeHaterAction(status: haterStatus)
}

func yearAlbumReleased(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    return nil
}

var items = ["James", "John", "Sally"]

func position(of string: String, in array [String]) -> Int {
    for i in 0..<array.count {
        if array[i] == string {
            return i
        }
    }
    return 0
}

let jamesPosition = position(of: "James", in: items)
let johnPosition = position(of: "John", in: items)
let sallyPosition = position(of: "Sally", in: items)
let bobPosition = position(of: "Bob", in: items) // returns 0 just like jamesPosition. That's bad. use an optional

func yearAlbumReleased(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    return nil
}

var year = yearAlbumReleased(name: "Taylor Swift")

if year == nil {
    print("There was an error")
} else {
    print("It was released in \(year)")
}