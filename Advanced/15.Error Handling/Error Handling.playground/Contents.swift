enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

throw VendingMachineError.insufficientFunds(coinsNeeded: 5)

//There are four ways to handle errors in Swift.
//1.You can propagate the error from a function to the code that calls that function
//2.handle the error using a do-catch statement
//3.handle the error as an optional value
//4.assert that the error will not occur




//Propagating Errors Using Throwing Functions
//you write the throws keyword before the return arrow (->).
func canThrowErrors() throws -> String {""}

func cannotThrowErrors() -> String {""}

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0

    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }

        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

//try buyFavoriteSnack(person: "Bob", vendingMachine: VendingMachine.init())

//Throwing initializers can propagate errors in the same way as throwing functions
struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}




//Handling Errors Using Do-Catch
//because it can throw an error. If an error is thrown, execution immediately transfers to the catch clauses
//If no pattern is matched, the error gets caught by the final catch clause and is bound to a local error constant. If no error is thrown, the remaining statements in the do statement are executed.
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}
// Prints "Insufficient funds. Please insert an additional 2 coins."

func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Couldn't buy that from the vending machine.")
    }
}

do {
    try nourish(with: "Beet-Flavored Chips")
} catch {
    print("Unexpected non-vending-machine-related error: \(error)")
}
// Prints "Couldn't buy that from the vending machine."

//Another way to catch several related errors is to list them after catch, separated by commas. For example:
func eat(item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch VendingMachineError.invalidSelection, VendingMachineError.insufficientFunds, VendingMachineError.outOfStock {
        print("Invalid selection, out of stock, or not enough money.")
    }
}



//Converting Errors to Optional Values
//You use try? to handle an error by converting it to an optional value.
//For example, in the following code x and y have the same value and behavior:

func someThrowingFunction() throws -> Int {
    1
}

let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}


//func fetchData() -> Data? {
//    if let data = try? fetchDataFromDisk() { return data }
//    if let data = try? fetchDataFromServer() { return data }
//    return nil
//}



//Disabling Error Propagation
//you can write try! before the expression to disable error propagation and wrap the call in a runtime assertion that no error will be thrown.

func loadImage(atPath: String) throws -> String{
    ""
}
let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")








//Specifying Cleanup Actions
//You use a defer statement to execute a set of statements just before code execution leaves the current block of code.
//The deferred statements may not contain any code that would transfer control out of the statements, such as a break or a return statement, or by throwing an error.

//That is, the code in the first defer statement executes last, the code in the second defer statement executes second to last, and so on. The last defer statement in source code order executes first.
//You can use a defer statement even when no error handling code is involved.
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
}

//Never mind the following as it was written to compile the processFile function
func exists(_ name: String) -> Bool{
    true
}

func close(_ filename: String) {
    
}

func open(_ name: String) -> String {
    ""
}

extension String {
    func readline() throws -> String? {
        ""
    }
}
