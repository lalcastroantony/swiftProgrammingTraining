//Classes have additional capabilities that structures don’t have:
//
//Inheritance enables one class to inherit the characteristics of another.
//Type casting enables you to check and interpret the type of a class instance at runtime.
//Deinitializers enable an instance of a class to free up any resources it has assigned.
//Reference counting allows more than one reference to a class instance.


//https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoMode = VideoMode()

print("The width of someResolution is \(someResolution.width)")
// Prints "The width of someResolution is 0"

print("The width of someVideoMode is \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is 0"

someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is now 1280"

//All structures have an automatically generated memberwise initializer
let vga = Resolution(width: 640, height: 480)
//Unlike structures, class instances don’t receive a default memberwise initializer.

//All of the basic types in Swift—integers, floating-point numbers, Booleans, strings, arrays and dictionaries—are value types, and are implemented as structures behind the scenes.

//Structures and enums are Value types
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
//declaring structure as constant won't allow you to change the properties read more about mutating if need to change
//let cinema = hd
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
// Prints "cinema is now 2048 pixels wide"
print("hd is still \(hd.width) pixels wide")
// Prints "hd is still 1920 pixels wide"

//The same behavior applies to enumerations:

enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")
// Prints "The current direction is north"
// Prints "The remembered direction is west"


//Classes Are Reference Types

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// Prints "The frameRate property of tenEighty is now 30.0"

//Note that tenEighty and alsoTenEighty are declared as constants, rather than variables. However, you can still change tenEighty.frameRate and alsoTenEighty.frameRate because the values of the tenEighty and alsoTenEighty constants themselves don’t actually change.

//Identity Operators
//Identical to (===)
//Not identical to (!==)

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
// Prints "tenEighty and alsoTenEighty refer to the same VideoMode instance."

let tenEighty1 = VideoMode()
tenEighty1.resolution = hd
tenEighty1.interlaced = true
tenEighty1.name = "1080i"
tenEighty1.frameRate = 25.0

let tenEighty2 = VideoMode()
tenEighty2.resolution = hd
tenEighty2.interlaced = true
tenEighty2.name = "1080i"
tenEighty2.frameRate = 25.0

if tenEighty1 === tenEighty2 {
    print("tenEighty1 and tenEighty2 refer to the same VideoMode instance.")
}
else {
    print("tenEighty1 and tenEighty2 are different VideoMode instances.")
}


//Pointers
//https://developer.apple.com/documentation/swift/swift_standard_library/manual_memory_management
