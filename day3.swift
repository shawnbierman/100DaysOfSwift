import Foundation

// Arithmetic operators

let firstScore = 12
let secondScore = 4

let total = firstScore + secondScore
let difference = firstScore - secondScore
let remainder = 13 % secondScore // returns 1

// Operator overloading

let meaningOfLife = 42
let doubleMeaningOfLife = 42 + 42

let fakers = "Fakers gonna "
let action = fakers + "fake"

let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]

let beatles = firstHalf + secondHalf

// Compound operators

 var score = 95
 score -= 5

 var quote = "The rain in spain falls mostly on the "
 quote += "Spaniards"

// Comparison operators

let firstScore = 6
let secondScore = 4

firstScore == secondScore
firstScore != secondScore

firstScore < secondScore
firstScore >= secondScore

"Taylor" <= "Swift"

// Conditions

let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 2 {
    print("Aces A lucky!")
} else firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}

// Combining conditions

let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

if age1 > 18 || age2 > 18 {
    print("One of them is over 18")
}

// Ternary operator

let firstCard = 11
let secondCard = 10
print(firstCard == secondCard ? "cards are the same" : "Cards are different")

if firstCard == secondCard {
    print("Cards are the same")
} else {
    print("Cards are different")
}

// Switch statements

let weather = "sunny"

switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}

// Range operators

let score = 85

switch score {
case 0..<50:
    print("You failed badly")
case 50..<50:
    print("You did okay")
default:
    print("You did great!")
}
