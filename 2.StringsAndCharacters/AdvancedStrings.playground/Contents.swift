














































//Strings Advanced Level

//Mutliline with " inside without using escaping characters
let multiLine = """
"hello"
"""
print(multiLine)


let exclamationMark: Character = "!"
let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]

var welcome = "Welcome"

welcome.append(exclamationMark)

//You can use extended string delimiters to create strings containing characters that would otherwise be treated as a string interpolation. For example:
print(#"Write an interpolated string in Swift using \(multiplier)."#)
// Prints "Write an interpolated string in Swift using \(multiplier)."



//To use string interpolation inside a string that uses extended delimiters, match the number of number signs after the backslash to the number of number signs at the beginning and end of the string. For example:

print(#"6 times 7 is \#(6 * 7)."#)
// Prints "6 times 7 is 42."

let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // e followed by
// eAcute is é, combinedEAcute is é



//Extended grapheme clusters enable scalars for enclosing marks (such as COMBINING ENCLOSING CIRCLE, or U+20DD) to enclose other Unicode scalars as part of a single Character value:


let copyRight: Character = "\u{63}\u{20DD}"
print(copyRight)
//prints c⃝

//Unicode scalars for regional indicator symbols can be combined in pairs to make a single Character value, such as this combination of REGIONAL INDICATOR SYMBOL LETTER U (U+1F1FA) and REGIONAL INDICATOR SYMBOL LETTER S (U+1F1F8):
//https://en.wikipedia.org/wiki/Regional_indicator_symbol

let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
// regionalIndicatorForUS is 🇺🇸

let regionalIndicatorForIndia: Character = "\u{1F1EE}\u{1F1F3}"
// regionalIndicatorForIndia is 🇮🇳

let stringVal:String = "\u{1F1EE}\u{1F1F3}"
print(stringVal.count)

let greeting = "Guten Tag!"
print(greeting[greeting.index(before: greeting.endIndex)])

//Uncomment to see the error
//print(greeting[greeting.endIndex])

print(greeting.startIndex) //startIndex will be 1, Not 0

//To access an index farther away from the given index, you can use the index(_:offsetBy:)
let index = greeting.index(greeting.startIndex, offsetBy: 7)
print(greeting[index])
// a

//Use the indices property to access all of the indices of individual characters in a string.

for index in greeting.indices {
    print("\(greeting[index]) ", terminator: "")
}
// Prints "G u t e n   T a g ! "



var welcomeMessage = "hello"
welcomeMessage.insert("!", at: welcomeMessage.endIndex)
// welcome now equals "hello!"

welcomeMessage.insert(contentsOf: " there", at: welcomeMessage.index(before: welcomeMessage.endIndex))
// welcome now equals "hello there!"

welcomeMessage.remove(at: welcomeMessage.index(before: welcomeMessage.endIndex))
// welcome now equals "hello there"

let range = welcomeMessage.index(welcomeMessage.endIndex, offsetBy: -6)..<welcomeMessage.endIndex
welcomeMessage.removeSubrange(range)
// welcome now equals "hello"


let greetingMessage = "Hello, world!"
let indexx = greetingMessage.firstIndex(of: ",") ?? greetingMessage.endIndex
let beginning = greetingMessage[..<indexx]
// beginning is "Hello"

// Convert the result to a String for long-term storage.
let newString = String(beginning)
//Like strings, each substring has a region of memory where the characters that make up the substring are stored. The difference between strings and substrings is that, as a performance optimization, a substring can reuse part of the memory that’s used to store the original string, or part of the memory that’s used to store another substring.



// "Voulez-vous un café?" using LATIN SMALL LETTER E WITH ACUTE
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"

// "Voulez-vous un café?" using LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}
// Prints "These two strings are considered equal"

let dogString = "Dog‼🐶" // the one used here is not the normal exclamation mark <!> it is <‼>
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}
print("")
// Prints "68 111 103 226 128 188 240 159 144 182 "

for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}
print("")
// Prints "68 111 103 8252 55357 56374 "


for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}
print("")
// Prints "68 111 103 8252 128054 "

for scalar in dogString.unicodeScalars {
    print("\(scalar) ")
}

for scalar in dogString.unicodeScalars {
    if scalar.properties.isEmoji {
        print("\(scalar) is an emoji")
    }
    else {
        print("\(scalar) is not an emoji")
    }
}


print(dogString.count)

print(dogString.utf8.count)

print(dogString.utf8.count)

print(dogString.unicodeScalars.count)


//Source form https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html
