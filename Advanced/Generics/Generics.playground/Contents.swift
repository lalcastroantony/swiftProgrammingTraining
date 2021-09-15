//Generic Functions
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
// someInt is now 107, and anotherInt is now 3

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
// someString is now "world", and anotherString is now "hello"

//Type Parameters
//In the swapTwoValues(_:_:) example above, the placeholder type T is an example of a type parameter. Type parameters specify and name a placeholder type, and are written immediately after the function’s name, between a pair of matching angle brackets (such as <T>).
//You can provide more than one type parameter by writing multiple type parameter names within the angle brackets, separated by commas.
//Always give type parameters upper camel case names (such as T and MyTypeParameter) to indicate that they’re a placeholder for a type, not a value.



//Generic Types
//These are custom classes, structures, and enumerations that can work with any type, in a similar way to Array and Dictionary.
//Here’s how to write a nongeneric version of a stack, in this case for a stack of Int values:
struct IntStack {
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//Here’s a generic version of the same code:
struct Stack<Element> {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// the stack now contains 4 strings
let fromTheTop = stackOfStrings.pop()
// fromTheTop is equal to "cuatro", and the stack now contains 3 strings


//Extending a Generic Type
//When you extend a generic type, you don’t provide a type parameter list as part of the extension’s definition.
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}
// Prints "The top item on the stack is tres."


//Type Constraints
//Type Constraint Syntax
//func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
//    // function body goes here
//}
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
// doubleIndex is an optional Int with no value, because 9.3 isn't in the array
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
// stringIndex is an optional Int containing a value of 2


//Associated Types
//When defining a protocol, it’s sometimes useful to declare one or more associated types as part of the protocol’s definition.
//Associated types are specified with the associatedtype keyword.
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//Here’s a version of the nongeneric IntStack type from Generic Types above, adapted to conform to the Container protocol:
//
//struct IntStack: Container {
//    // original IntStack implementation
//    var items: [Int] = []
//    mutating func push(_ item: Int) {
//        items.append(item)
//    }
//    mutating func pop() -> Int {
//        return items.removeLast()
//    }
//    // conformance to the Container protocol
//    typealias Item = Int
//    mutating func append(_ item: Int) {
//        self.push(item)
//    }
//    var count: Int {
//        return items.count
//    }
//    subscript(i: Int) -> Int {
//        return items[i]
//    }
//}


struct Stackk<Element>: Container {
    // original Stack<Element> implementation
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}


//Extending an Existing Type to Specify an Associated Type
extension Array: Container {}

//Adding Constraints to an Associated Type
protocol Containerr {
    associatedtype Item: Equatable //Constraint
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}


//Using a Protocol in Its Associated Type’s Constraints
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stackk: SuffixableContainer {
    func suffix(_ size: Int) -> Stackk {
        var result = Stackk()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack.
}
var stackOfInts = Stackk<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)
// suffix contains 20 and 30


//Generic Where Clauses
func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {

        // Check that both containers contain the same number of items.
        if someContainer.count != anotherContainer.count {
            return false
        }

        // Check each pair of items to see if they're equivalent.
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }

        // All items match, so return true.
        return true
}


//Extensions with a Generic Where Clause
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

if stackOfStrings.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else.")
}
// Prints "Top element is tres."

//If you try to call the isTop(_:) method on a stack whose elements aren’t equatable, you’ll get a compile-time error.

//struct NotEquatable { }
//var notEquatableStack = Stack<NotEquatable>()
//let notEquatableValue = NotEquatable()
//notEquatableStack.push(notEquatableValue)
//notEquatableStack.isTop(notEquatableValue)  // Error

extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

if [9, 9, 9].startsWith(42) {
    print("Starts with 42.")
} else {
    print("Starts with something else.")
}
// Prints "Starts with something else."

extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}
print([1260.0, 1200.0, 98.6, 37.0].average())
// Prints "648.9"
//uncomment the below to see the error
//print(["1260", "1200", "98", "37"].average())


//Contextual Where Clauses
//extension Container {
//    func average() -> Double where Item == Int {
//        var sum = 0.0
//        for index in 0..<count {
//            sum += Double(self[index])
//        }
//        return sum / Double(count)
//    }
//    func endsWith(_ item: Item) -> Bool where Item: Equatable {
//        return count >= 1 && self[count-1] == item
//    }
//}
//let numbers = [1260, 1200, 98, 37]
//print(numbers.average())
//// Prints "648.75"
//print(numbers.endsWith(37))
//// Prints "true"
///
//extension Container where Item == Int {
//func average() -> Double {
//    var sum = 0.0
//    for index in 0..<count {
//        sum += Double(self[index])
//    }
//    return sum / Double(count)
//}
//}
//extension Container where Item: Equatable {
//func endsWith(_ item: Item) -> Bool {
//    return count >= 1 && self[count-1] == item
//}
//}


//Generic Subscripts
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result: [Item] = []
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}
