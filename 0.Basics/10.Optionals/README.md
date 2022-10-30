# 10.Optionals

* You use optionals in situations where a value may be absent.
* Example with “123” to Int
* Syntax for declaring optionals
* you set an optional variable to a valueless state by assigning it the special value nil:
* If you define an optional variable without providing a default value, the variable is automatically set to nil for you
* If Statements and Forced Unwrapping ( != nil and using !)
* Optional Binding (if let or if var)
* Read as “If the optional Int returned by Int(possibleNumber) contains a value, set a new constant called actualNumber to the value contained in the optional.”
* You can include as many optional bindings and Boolean conditions in a single if statement as you need to, separated by commas.
* Constants and variables created with optional binding in an if statement are available only within the body of the if statement.
* Implicitly Unwrapped Optionals
* If an implicitly unwrapped optional is nil and you try to access its wrapped value, you’ll trigger a runtime error. The result is exactly the same as if you place an exclamation point after a normal optional that doesn’t contain a value.
* If statement optional check and optional binding can be done with an implicitly unwrapped optional  too


https://www.youtube.com/watch?v=ZV9IU0bhlI8
