//Basic Operators

//Operators are unary, binary, or ternary
//Operands vs Operators




//Assignment Operator
let b = 10
var a = 5
a = b
// a is now equal to 10
let (x, y) = (1, 2)
//uncomment the below to see the error
//if a = b {
//    // This isn't valid, because x = y doesn't return a value.
//}

















//Arithmetic Operators
//Addition (+)
//Subtraction (-)
//Multiplication (*)
//Division (/)
var value = 1 + 2       // equals 3
value = 5 - 3       // equals 2
value = 2 * 3       // equals 6
let four = 10.0 / 2.5  // equals 4.0

//The addition operator is also supported for String concatenation:
let welcomeMessage = "hello, " + "world"  // equals "hello, world"
















//Remainder Operator
//The remainder operator (a % b) works out how many multiples of b will fit inside a and returns the value that’s left over (known as the remainder).
var remainder = 9 % 4    // equals 1
//a = (b x some multiplier) + remainder
//9 = (4 x 2) + 1
//The same method is applied when calculating the remainder for a negative value of a:
remainder = -9 % 4   // equals -1
//-9 = (4 x -2) + -1












//Unary Minus Operator
let three = 3
let minusThree = -three       // minusThree equals -3
let plusThree = -minusThree   // plusThree equals 3, or "minus minus three"













//Unary Plus Operator
//The unary plus operator (+) simply returns the value it operates on, without any change:
let minusSix = -6
let alsoMinusSix = +minusSix  // alsoMinusSix equals -6












//Compound Assignment Operators
var aNumber = 1
aNumber += 2
// a is now equal to 3
















//Comparison Operators
//Swift supports the following comparison operators:
//
//Equal to (a == b)
//Not equal to (a != b)
//Greater than (a > b)
//Less than (a < b)
//Greater than or equal to (a >= b)
//Less than or equal to (a <= b)

//Each of the comparison operators returns a Bool value to indicate whether or not the statement is true:
1 == 1   // true because 1 is equal to 1
2 != 1   // true because 2 isn't equal to 1
2 > 1    // true because 2 is greater than 1
1 < 2    // true because 1 is less than 2
1 >= 1   // true because 1 is greater than or equal to 1
2 <= 1   // false because 2 isn't less than or equal to 1

//Comparison operators are often used in conditional statements, such as the if statement:
let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}
// Prints "hello, world", because name is indeed equal to "world".

//You can compare two tuples if they have the same type and the same number of values. Tuples are compared from left to right.
(1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" aren't compared
(3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
(4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"
("blue", -1) < ("purple", 1)        // OK, evaluates to true
//uncomment the below to see the error
//("blue", false) < ("purple", true)  // Error because < can't compare Boolean values
















//Ternary Conditional Operator
//condition ? chooseThisifTrue : chooseThisifFalse
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight is equal to 90

//The example above is shorthand for the code below:
let contentHeight1 = 40
let hasHeader1 = true
let rowHeight1: Int
if hasHeader1 {
    rowHeight1 = contentHeight1 + 50
} else {
    rowHeight1 = contentHeight1 + 20
}
// rowHeight1 is equal to 90














//Nil-Coalescing Operator
//The nil-coalescing operator (a ?? b) unwraps an optional a if it contains a value, or returns a default value b if a is nil.
//If the value of a is non-nil, the value of b isn’t evaluated. This is known as short-circuit evaluation.
//The nil-coalescing operator is shorthand for the code below:
//a != nil ? a! : b
let defaultColorName = "red"
var userDefinedColorName: String?   // defaults to nil
var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName is nil, so colorNameToUse is set to the default of "red"

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName isn't nil, so colorNameToUse is set to "green"













//Range Operators

//Closed Range Operator
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
// 1 times 5 is 5
// 2 times 5 is 10
// 3 times 5 is 15
// 4 times 5 is 20
// 5 times 5 is 25

//Half-Open Range Operator
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}
// Person 1 is called Anna
// Person 2 is called Alex
// Person 3 is called Brian
// Person 4 is called Jack

//One-Sided Ranges
for name in names[2...] {
    print(name)
}
// Brian
// Jack

for name in names[...2] {
    print(name)
}
// Anna
// Alex
// Brian

for name in names[..<2] {
    print(name)
}
// Anna
// Alex

//Ranges can be used in other contexts
let range = 1...5
range.contains(7)   // false
range.contains(4)   // true
range.contains(-1)  // true




















//Logical Operators
//Logical operators modify or combine the Boolean logic values true and false. Swift supports the three standard logical operators found in C-based languages:
//
//Logical NOT (!a)
//Logical AND (a && b)
//Logical OR (a || b)

//Logical NOT Operator
let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}
// Prints "ACCESS DENIED"

//Logical AND Operator
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "ACCESS DENIED"

//Logical OR Operator
let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"

//Combining Logical Operators
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
//If we’ve entered the correct door code and passed the retina scan, or if we have a valid door key, or if we know the emergency override password, then allow access.

//The Swift logical operators && and || are left-associative, meaning that compound expressions with multiple logical operators evaluate the leftmost subexpression first.

//Explicit Parentheses
//It’s sometimes useful to include parentheses when they’re not strictly needed, to make the intention of a complex expression easier to read.

if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
