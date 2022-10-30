//11.Error Handling
//
//* You use error handling to respond to error conditions your program may encounter during execution.
//* When a function encounters an error condition, it throws an error. That function’s caller can then catch the error and respond appropriately.
//* Keywords:  throws, throw, do, try, catch

enum SandwichError: Error {
    case outOfCleanDishes
    case missingIngredients(ingredients: [String])
}

do {
    try makeASandwich()
    eatASandwich()
} catch SandwichError.outOfCleanDishes {
    washDishes()
} catch SandwichError.missingIngredients(let ingredients) {
    buyGroceries(ingredients: ingredients)
}

func makeASandwich() throws {
        
    let missingIngredients: [String] = ["Bread", "Eggs"]
    let cleanDishesCount = 5
    
    if missingIngredients.count > 0 {
        print("Missing ingredients 😲")
        throw SandwichError.missingIngredients(ingredients: missingIngredients)
    }
    else if cleanDishesCount == 0 {
        print("Out of clean dishes 😒")
        throw SandwichError.outOfCleanDishes
    }
    print("Made Sandwich 😁")
}

func eatASandwich() {
    print("Eating Sandwich 🥪")
}

func washDishes() {
    print("Washing dishes 🍽")
}

func buyGroceries(ingredients: [String]) {
    print("Going shopping for \(ingredients.joined(separator: ",")) 🛍")
}




