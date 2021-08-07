//6.Numeric Conversion
//
//* Can’t store different type or beyond range
//* Int8 to Int16 conversion
//* Adding Int8 and Int16
//* Integer and Floating point Addition
//* Converting Float to Int


//Uncomment the below line to see the error
//let notNegative: Int8 = Int8.max + 1

//Uncomment the below line to see the error
//let notNegative: UInt = -20

let number1: Int8 = 16
let number2: Int16 = 50

let sum = Int16(number1) + number2

let intNum: Int = 10
let floatNum: Double = 4.89

let sum1 = Double(intNum) + floatNum

let pi = 3.14
let convertedPi =  Int(pi)
