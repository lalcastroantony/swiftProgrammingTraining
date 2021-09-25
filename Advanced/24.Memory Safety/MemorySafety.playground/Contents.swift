//Understanding Conflicting Access to Memory
// A write access to the memory where one is stored.
var one = 1

// A read access from the memory where one is stored.
print("We're number \(one)!")

//Characteristics of Memory Access
//1.At least one is a write access or a nonatomic access.
//2.They access the same location in memory.
//3.Their durations overlap.

//Conflicting Access to In-Out Parameters
var stepSize = 1

func increment(_ number: inout Int) {
    number += stepSize
}

//Uncomment and run to see the error
//increment(&stepSize)

//One way to solve this conflict is to make an explicit copy of stepSize:

// Make an explicit copy.
var copyOfStepSize = stepSize
increment(&copyOfStepSize)

// Update the original.
stepSize = copyOfStepSize
// stepSize is now 2


func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)  // OK
//balance(&playerOneScore, &playerOneScore)
// Error: conflicting accesses to playerOneScore
//In contrast, passing playerOneScore as the value for both parameters produces a conflict because it tries to perform two write accesses to the same location in memory at the same time.


//Conflicting Access to self in Methods
struct Player {
    var name: String
    var health: Int
    var energy: Int

    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}
extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)  // OK
//oscar.shareHealth(with: &oscar)
// Error: conflicting accesses to oscar

//Conflicting Access to Properties

//with tuple
var playerInformation = (health: 10, energy: 20)
//balance(&playerInformation.health, &playerInformation.energy)
// Error: conflicting access to properties of playerInformation

//The code below shows that the same error appears for overlapping write accesses to the properties of a structure that’s stored in a global variable.
var holly = Player(name: "Holly", health: 10, energy: 10)
balance(&holly.health, &holly.energy)  // Error

//In practice, most access to the properties of a structure can overlap safely. For example, if the variable holly in the example above is changed to a local variable instead of a global variable, the compiler can prove that overlapping access to stored properties of the structure is safe:

func someFunction() {
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy)  // OK
}
