//Here, self disambiguates between a method parameter called x and an instance property that’s also called x:
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}
// Prints "This point is to the right of the line where x == 1.0"



//Modifying Value Types from Within Instance Methods
//The properties of a value type can’t be modified from within its instance methods.
//However, if you need to modify the properties of your structure or enumeration within a particular method, you can opt in to mutating behavior for that method.
struct Pointt {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePointt = Pointt(x: 1.0, y: 1.0)
somePointt.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePointt.x), \(somePointt.y))")
// Prints "The point is now at (3.0, 4.0)"


//Note that you can’t call a mutating method on a constant of structure type, because its properties can’t be changed
let fixedPoint = Point(x: 3.0, y: 3.0)
//fixedPoint.moveBy(x: 2.0, y: 3.0)
// this will report an error


//Assigning to self Within a Mutating Method
struct Pointtt {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Pointtt(x: x + deltaX, y: y + deltaY)
    }
}


//Mutating methods for enumerations can set the implicit self parameter to be a different case from the same enumeration:
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
// ovenLight is now equal to .high
ovenLight.next()
// ovenLight is now equal to .off


//Type Methods
//You indicate type methods by writing the static keyword before the method’s func keyword. Classes can use the class keyword instead, to allow subclasses to override the superclass’s implementation of that method.
class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here
    }
}
SomeClass.someTypeMethod()

//Within the body of a type method, the implicit self property refers to the type itself, rather than an instance of that type
//A type method can call another type method with the other method’s name, without needing to prefix it with the type name.
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1

    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }

    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }

//    method to ignore the return value, this function is marked with the @discardableResult attribute
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// Prints "highest unlocked level is now 2"

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 hasn't yet been unlocked")
}
// Prints "level 6 hasn't yet been unlocked"


