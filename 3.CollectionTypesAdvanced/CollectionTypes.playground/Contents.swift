//Collection Types - Array, Set, Dictionary

//Mutability of Collections - let and var



//1.Array
//An array stores values of the same type in an ordered list. The same value can appear in an array multiple times at different positions.


//Creating an Empty Array
var someInts: [Int] = []

someInts.append(3)
// someInts now contains 1 value of type Int

//print(someInts)

someInts = []
// someInts is now an empty array, but is still of type [Int]









//Creating an Array with a Default Value

var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]










//Creating an Array by Adding Two Arrays Together

var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]

var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]











//Creating an Array with an Array Literal

var shoppingList: [String] = ["Eggs", "Milk"]

shoppingList.isEmpty //false

shoppingList.append("Flour")

shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
shoppingList

//Retrieve a value from the array by using subscript syntax
var firstItem = shoppingList[0]
// firstItem is equal to "Eggs"


//You can use subscript syntax to change an existing value at a given index
shoppingList[0] = "Six eggs"
// the first item in the list is now equal to "Six eggs" rather than "Eggs"

//uncomment the below to see the runtime error
//shoppingList[shoppingList.count] = "Salt"
shoppingList
shoppingList[4...6] = ["Bananas", "Apples"]
shoppingList

shoppingList.insert("Maple Syrup", at: 0)
shoppingList

let mapleSyrup = shoppingList.remove(at: 0)
let apples = shoppingList.removeLast()
shoppingList


//Iterating Over an Array
for item in shoppingList {
//    print(item)
}


for (index, value) in shoppingList.enumerated() {
//    print("Item \(index + 1): \(value)")
}




























//2.Sets
//A set stores distinct values of the same type in a collection with no defined ordering. You can use a set instead of an array when the order of items isn’t important, or when you need to ensure that an item only appears once.

//Creating and Initializing an Empty Set

var letters = Set<String>()
//print("letters is of type Set<String> with \(letters.count) items.")

letters.insert("Lal")
// letters now contains 1 value of type String
letters = []
// letters is now an empty set, but is still of type Set<String>




//Creating a Set with an Array Literal
var favoriteGenress: Set<String> = ["Rock", "Classical", "Hip hop", "Hip hop"]
//print(favoriteGenress)

var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]





//Accessing and Modifying a Set
favoriteGenres.insert("Jazz")

if let removedGenre = favoriteGenres.remove("Rock") {
//    print("\(removedGenre)? I'm over it.")
} else {
//    print("I never much cared for that.")
}
// Prints "Rock? I'm over it."




//print(favoriteGenres.contains("Funk"))



//Iterating Over a Set

for genre in favoriteGenres {
//    print("\(genre)")
}

for genre in favoriteGenres.sorted() {
//    print("\(genre)")
}




//Performing Set Operations

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

setA == setB // true
setA.isStrictSubset(of: setB) // false
setB.isStrictSuperset(of: setB) // false






























//3.Dictionary
var namesOfIntegers: [Int: String] = [:]
//var serverResponse: [String: Any] = [:]
namesOfIntegers[16] = "sixteen"

namesOfIntegers
// namesOfIntegers now contains 1 key-value pair
namesOfIntegers = [:]
// namesOfIntegers is once again an empty dictionary of type [Int: String]








var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"] // [String: String]
airports["LHR"] = "London"
airports["LHR"] = "London Heathrow"
airports



//As an alternative to subscripting, use a dictionary’s updateValue(_:forKey:) method to set or update the value for a particular key.
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}
// Prints "The old value for DUB was Dublin."

airports


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

airports






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

