//Reference counting applies only to instances of classes. Structures and enumerations are value types, not reference types, and aren’t stored and passed by reference.

//ARC will not deallocate an instance as long as at least one active reference to that instance still exists.
//To make this possible, whenever you assign a class instance to a property, constant, or variable, that property, constant, or variable makes a strong reference to the instance. The reference is called a “strong” reference because it keeps a firm hold on that instance, and doesn’t allow it to be deallocated for as long as that strong reference remains.

//ARC in Action
class Personn {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
var reference1: Personn?
var reference2: Personn?
var reference3: Personn?
reference1 = Personn(name: "John Appleseed")
// Prints "John Appleseed is being initialized"
reference2 = reference1
reference3 = reference1
//There are now three strong references to this single Person instance.
reference1 = nil
reference2 = nil
//ARC doesn’t deallocate the Person instance until the third and final strong reference is broken, at which point it’s clear that you are no longer using the Person instance:
reference3 = nil
// Prints "John Appleseed is being deinitialized"



//Strong Reference Cycles Between Class Instances
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}
class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
var john: Person?
var unit4A: Apartment?
john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
john!.apartment = unit4A
unit4A!.tenant = john

john = nil
unit4A = nil
//Note that neither deinitializer was called when you set these two variables to nil. The strong reference cycle prevents the Person and Apartment instances from ever being deallocated, causing a memory leak in your app.



//Resolving Strong Reference Cycles Between Class Instances
//Use a weak reference when the other instance has a shorter lifetime—that is, when the other instance can be deallocated first. In the Apartment example above, it’s appropriate for an apartment to be able to have no tenant at some point in its lifetime, and so a weak reference is an appropriate way to break the reference cycle in this case. In contrast, use an unowned reference when the other instance has the same lifetime or a longer lifetime.


//Weak References
//Because weak references need to allow their value to be changed to nil at runtime, they’re always declared as variables, rather than constants, of an optional type.
//Property observers aren’t called when ARC sets a weak reference to nil.
class Person1 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment1?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment1 {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person1?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var johN: Person1?
var unit4AB: Apartment1?

johN = Person1(name: "John Appleseed")
unit4AB = Apartment1(unit: "4AB")

johN!.apartment = unit4AB
unit4AB!.tenant = johN
johN = nil
// Prints "johN Appleseed is being deinitialized"
print(unit4AB?.tenant == nil)
//true

unit4A = nil
// Prints "Apartment 4A is being deinitialized"
//Because there are no more strong references to the Apartment instance, it too is deallocated:




//Unowned References
//Unlike a weak reference, however, an unowned reference is used when the other instance has the same lifetime or a longer lifetime. You indicate an unowned reference by placing the unowned keyword before a property or variable declaration.
//
//Unlike a weak reference, an unowned reference is expected to always have a value. As a result, marking a value as unowned doesn’t make it optional, and ARC never sets an unowned reference’s value to nil.
//If you try to access the value of an unowned reference after that instance has been deallocated, you’ll get a runtime error.

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}
//Because a credit card will always have a customer, you define its customer property as an unowned reference, to avoid a strong reference cycle:
var randy: Customer?
randy = Customer(name: "Randy Orton")
randy!.card = CreditCard(number: 1234_5678_9012_3456, customer: randy!)
//Because of the unowned customer reference, when you break the strong reference held by the john variable, there are no more strong references to the Customer instance:
//Because there are no more strong references to the Customer instance, it’s deallocated. After this happens, there are no more strong references to the CreditCard instance, and it too is deallocated:
randy = nil
// Prints "John Appleseed is being deinitialized"
// Prints "Card #1234567890123456 is being deinitialized"



//Unowned Optional References
//The difference is that when you use an unowned optional reference, you’re responsible for making sure it always refers to a valid object or is set to nil.
class Department {
    var name: String
    var courses: [Course]
    init(name: String) {
        self.name = name
        self.courses = []
    }
}
class Course {
    var name: String
    unowned var department: Department
    unowned var nextCourse: Course?
    init(name: String, in department: Department) {
        self.name = name
        self.department = department
        self.nextCourse = nil
    }
}
let department = Department(name: "Horticulture")

let intro = Course(name: "Survey of Plants", in: department)
let intermediate = Course(name: "Growing Common Herbs", in: department)
let advanced = Course(name: "Caring for Tropical Plants", in: department)

intro.nextCourse = intermediate
intermediate.nextCourse = advanced
department.courses = [intro, intermediate, advanced]

//Like non-optional unowned references, you’re responsible for ensuring that nextCourse always refers to a course that hasn’t been deallocated. In this case, for example, when you delete a course from department.courses you also need to remove any references to it that other courses might have




//Unowned References and Implicitly Unwrapped Optional Properties
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
//All of this means that you can create the Country and City instances in a single statement, without creating a strong reference cycle, and the capitalCity property can be accessed directly, without needing to use an exclamation point to unwrap its optional value:
//The capitalCity property can be used and accessed like a non-optional value once initialization is complete, while still avoiding a strong reference cycle.
var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")
// Prints "Canada's capital city is called Ottawa"



//Strong Reference Cycles for Closures
//A strong reference cycle can also occur if you assign a closure to a property of a class instance, and the body of that closure captures the instance. This capture might occur because the closure’s body accesses a property of the instance, such as self.someProperty, or because the closure calls a method on the instance, such as self.someMethod(). In either case, these accesses cause the closure to “capture” self, creating a strong reference cycle.
//This strong reference cycle occurs because closures, like classes, are reference types.
class HTMLElement {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }

}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
// Prints "<h1>some default text</h1>"

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// Prints "<p>hello, world</p>"

//If you set the paragraph variable to nil and break its strong reference to the HTMLElement instance, neither the HTMLElement instance nor its closure are deallocated, because of the strong reference cycle:
paragraph = nil

//Note that the message in the HTMLElement deinitializer isn’t printed, which shows that the HTMLElement instance isn’t deallocated.



//Resolving Strong Reference Cycles for Closures
//Swift requires you to write self.someProperty or self.someMethod() (rather than just someProperty or someMethod()) whenever you refer to a member of self within a closure. This helps you remember that it’s possible to capture self by accident.

//Defining a Capture List
//Place the capture list before a closure’s parameter list and return type if they’re provided:

//lazy var someClosure = {
//    [unowned self, weak delegate = self.delegate]
//    (index: Int, stringToProcess: String) -> String in
//    // closure body goes here
//}
//If a closure doesn’t specify a parameter list or return type because they can be inferred from context, place the capture list at the very start of the closure, followed by the in keyword:

//lazy var someClosure = {
//    [unowned self, weak delegate = self.delegate] in
//    // closure body goes here
//}

//Weak and Unowned References
//If the captured reference will never become nil, it should always be captured as an unowned reference, rather than a weak reference.
class HTMLElementt {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }

}

var paragraphh: HTMLElementt? = HTMLElementt(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// Prints "<p>hello, world</p>

paragraphh = nil
// Prints "p is being deinitialized"


