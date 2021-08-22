//Collection Types

//Array

var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]

var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]

var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]

var shoppingList: [String] = ["Eggs", "Milk"]

shoppingList.isEmpty

shoppingList.append("Flour")

shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
shoppingList

//uncomment the below to see the runtime error
//shoppingList[shoppingList.count] = "Salt"

shoppingList[4...6] = ["Bananas", "Apples"]
shoppingList

shoppingList.insert("Maple Syrup", at: 0)
shoppingList

let mapleSyrup = shoppingList.remove(at: 0)
let apples = shoppingList.removeLast()

for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}


//Sets


var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")

letters.insert("a")
// letters now contains 1 value of type Character
letters = []
// letters is now an empty set, but is still of type Set<Character>

var favoriteGenress: Set<String> = ["Rock", "Classical", "Hip hop", "Hip hop"]
print(favoriteGenress)

var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]

favoriteGenres.insert("Jazz")

if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}
// Prints "Rock? I'm over it."

print(favoriteGenres.contains("Funk"))

for genre in favoriteGenres {
    print("\(genre)")
}

for genre in favoriteGenres.sorted() {
    print("\(genre)")
}

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted()
// []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
// [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
// [1, 2, 9]

//Use the “is equal” operator (==) to determine whether two sets contain all of the same values.
//Use the isSubset(of:) method to determine whether all of the values of a set are contained in the specified set.
//Use the isSuperset(of:) method to determine whether a set contains all of the values in a specified set.
//Use the isStrictSubset(of:) or isStrictSuperset(of:) methods to determine whether a set is a subset or superset, but not equal to, a specified set.
//Use the isDisjoint(with:) method to determine whether two sets have no values in common.

let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

let setA: Set = ["hi","hello"]
let setB: Set = ["hi","hello"]

houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true
farmAnimals.isStrictSuperset(of: houseAnimals)
//true
houseAnimals.isStrictSubset(of: farmAnimals)
//true

setA == setB
setA.isStrictSubset(of: setB)
setB.isStrictSuperset(of: setB)



//Dictionary
var namesOfIntegers: [Int: String] = [:]
namesOfIntegers[16] = "sixteen"
// namesOfIntegers now contains 1 key-value pair
namesOfIntegers = [:]
// namesOfIntegers is once again an empty dictionary of type [Int: String]

var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
airports["LHR"] = "London"
airports["LHR"] = "London Heathrow"

//As an alternative to subscripting, use a dictionary’s updateValue(_:forKey:) method to set or update the value for a particular key.
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}
// Prints "The old value for DUB was Dublin."

if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport isn't in the airports dictionary.")
}
// Prints "The name of the airport is Dublin Airport."

//You can use subscript syntax to remove a key-value pair from a dictionary by assigning a value of nil for that key:

airports["APL"] = "Apple International"
// "Apple International" isn't the real airport for APL, so delete it
airports["APL"] = nil
// APL has now been removed from the dictionary

if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary doesn't contain a value for DUB.")
}
// Prints "The removed airport's name is Dublin Airport."

for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}


for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}


for airportName in airports.values {
    print("Airport name: \(airportName)")
}

for airportCode in airports.keys.sorted() {
    print("Airport code: \(airportCode)")
}

for airportName in airports.values.sorted() {
    print("Airport name: \(airportName)")
}

//If you need to use a dictionary’s keys or values with an API that takes an Array instance, initialize a new array with the keys or values property:

let airportCodes = [String](airports.keys)

let airportNames = [String](airports.values)

