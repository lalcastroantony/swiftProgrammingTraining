//Computed properties are provided by classes, structures, and enumerations. Stored properties are provided only by classes and structures.

//Stored Properties

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6
// the range now represents integer values 6, 7, and 8

//Stored Properties of Constant Structure Instances
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// this range represents integer values 0, 1, 2, and 3
//rangeOfFourItems.firstValue = 6
// this will report an error, even though firstValue is a variable property

//This behavior is due to structures being value types. When an instance of a value type is marked as a constant, so are all of its properties.


//Lazy Stored Properties
//You must always declare a lazy property as a variable (with the var keyword), because its initial value might not be retrieved until after instance initialization completes. Constant properties must always have a value before initialization completes, and therefore can’t be declared as lazy.

class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// the DataImporter instance for the importer property hasn't yet been created


print(manager.importer.filename)
// the DataImporter instance for the importer property has now been created
// Prints "data.txt"


//If a property marked with the lazy modifier is accessed by multiple threads simultaneously and the property hasn’t yet been initialized, there’s no guarantee that the property will be initialized only once.

//Computed Properties
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// Prints "square.origin is now at (10.0, 10.0)"



//Shorthand Setter Declaration
//If a computed property’s setter doesn’t define a name for the new value to be set, a default name of newValue is used.

struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//Shorthand Getter Declaration
//If the entire body of a getter is a single expression, the getter implicitly returns that expression.

struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//Read-Only Computed Properties
//A computed property with a getter but no setter is known as a read-only computed property.

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
//        get {
            return width * height * depth
//        }
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// Prints "the volume of fourByFiveByTwo is 40.0"


//You must declare computed properties—including read-only computed properties—as variable properties with the var keyword, because their value isn’t fixed.


//Property Observers
//Property observers are called every time a property’s value is set, even if the new value is the same as the property’s current value.
//You can add property observers in the following places:
//
//Stored properties that you define
//Stored properties that you inherit
//Computed properties that you inherit

//You have the option to define either or both of these observers on a property:
//
//willSet is called just before the value is stored.
//didSet is called immediately after the new value is stored.

//willSet - the parameter is made available with a default parameter name of newValue.
//didSet - You can name the parameter or use the default parameter name of oldValue.


class StepCounter {
    var totalSteps: Int = 0 {
        willSet {
            print("About to set totalSteps to \(newValue)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps

//If you pass a property that has observers to a function as an in-out parameter, the willSet and didSet observers are always called.


//Property Wrapper

@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)
// Prints "0"

rectangle.height = 10
print(rectangle.height)
// Prints "10"

rectangle.height = 24
print(rectangle.height)
// Prints "12"

//Code that uses this property wrapper, can’t specify a different initial value


//Without using Property wrapper
struct SmallRectanglee {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}



//Setting Initial Values for Wrapped Properties
//To support setting an initial value or other customization, the property wrapper needs to add an initializer.
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}


//When you apply a wrapper to a property and you don’t specify an initial value, Swift uses the init() initializer to set up the wrapper

struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)
// Prints "0 0"

struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}

//When you write = 1 on a property with a wrapper, that’s translated into a call to the init(wrappedValue:) initializer.

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)
// Prints "1 1"


struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)
// Prints "2 3"

narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)
// Prints "5 4"

struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}

var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)
// Prints "1"

mixedRectangle.height = 20
print(mixedRectangle.height)
// Prints "12"

mixedRectangle.width = 57
print(mixedRectangle.width)
// Prints "9"



//ProjectedValue
@propertyWrapper
struct SmallNumberr {
    private var number = 0
    var projectedValue = false
    init() {
        self.number = 0
      }
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
}
struct SomeStructure {
    @SmallNumberr var someNumber: Int
}
var someStructure = SomeStructure()

someStructure.someNumber = 4
print(someStructure.$someNumber)
// Prints "false"

someStructure.someNumber = 55
print(someStructure.$someNumber)
// Prints "true"


enum Sizee {
    case small, large
}

struct SizedRectangle {
    @SmallNumberr var height: Int
    @SmallNumberr var width: Int

    mutating func resize(to size: Sizee) -> Bool {
        switch size {
        case .small:
            height = 10
            width = 20
        case .large:
            height = 100
            width = 100
        }
        return $height || $width
    }
}


var sizedRect = SizedRectangle()
print(sizedRect.width)
print(sizedRect.height)

let resize = sizedRect.resize(to: .large)

print(sizedRect.width)
print(sizedRect.height)


//Global constants and variables are always computed lazily
//Unlike lazy stored properties, global constants and variables don’t need to be marked with the lazy modifier.

//You can apply a property wrapper to a local stored variable, but not to a global variable or a computed variable.


//Type Properties
//Unlike stored instance properties, you must always give stored type properties a default value. This is because the type itself doesn’t have an initializer that can assign a value to a stored type property at initialization time.

//Stored type properties are lazily initialized on their first access. They’re guaranteed to be initialized only once, even when accessed by multiple threads simultaneously, and they don’t need to be marked with the lazy modifier.


//You define type properties with the static keyword. For computed type properties for class types, you can use the class keyword instead to allow subclasses to override the superclass’s implementation. The example below shows the syntax for stored and computed type properties:

struct SomeStructuree {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
