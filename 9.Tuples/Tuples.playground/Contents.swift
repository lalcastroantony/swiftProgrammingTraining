//9.Tuples
//
//* Group multiple values into a single compound value
//* Can be of any type and don’t have to be of the same type as each other
//* It can be described as “a tuple of type (Int, String)”.
//* Accessing a tuple’s component
//* Can create tuples from any permutation of types (Int, Int, Int), or (String, Bool)
//* Ignore parts of the tuple with an underscore (_)
//* Can be accessed with index
//* Can name the individual elements in a tuple
//* Useful as the return values of functions
//* Tuples are useful for simple groups of related values
//* They’re not suited to the creation of complex data structures.

let http404Error = (404, "Not Found")

let (statusCode, message) = http404Error

print("statusCode: \(statusCode)")
print("Message: \(message)")

//let (justTheStatusCode, _) = http404Error

let justStatusCode = http404Error.0

let http200Success = (statusCode: 200, message: "Success")

let successCode = http200Success.statusCode
let successMessage = http200Success.message
