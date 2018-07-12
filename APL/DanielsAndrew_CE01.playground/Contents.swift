/*
 Andrew Daniels
 APL-L 1711
 */

import UIKit


/* Part 1: Variable Declarations  */

let explicitBool: Bool = false
var implicitArrayOfStrings = ["The", "Array", "Of", "Strings"]
var explicitFloat: Float = 4.44444
//Implicitly declare an EMPTY array of Ints
var implicitEmptyArrayOfInts = [Int]()
let explicitConstant: UInt32 = 13
//Implicity declare an array of arrays of Doubles
var implicitArrayOfArraysOfDoubles = [[4.44, 5.55],[6.67, 7.77]]


/* Part 2: String Concatenation */

var cityName = "West Des Moines"
var stateName = "Iowa"

var hometown = cityName + ", " + stateName

var population = 64_560

print("I live in \(hometown), which has \(population) people that live there.")


/* Part 3: Arrays, Conditionals, and Loops */
var arrayOfStrings = [String]()

for i in 1...5 {
    arrayOfStrings.append("Swift_\(i)")
    if arrayOfStrings.count == 5 {
        for item in arrayOfStrings{
            print(item)
        }
    } else {
        print("Here is my array: \(arrayOfStrings). I must have added the wrong number of elements to it.")
    }
}

/* Part 4: Random Values */

var randomInt: Int = Int(arc4random_uniform(1000))
var randomInt2: Int = Int(arc4random())
var randomInt3: Int = Int(arc4random_uniform(23) + 9)
var randomInt4: Double = Double(arc4random()) / Double(UInt32.max)


/* Part 5: Documentation Scavenger Hunt - Arrays and Strings */

/*
 //Found this information here: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html#//apple_ref/doc/uid/TP40014097-CH8-ID105
 //In the first sentence
 1. Sets and Dictionaries
 //Found here https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID285
 //Under Substrings header
 2. The substring structure allows you to modify a current string in a separate instance, while still using the first strings memory. Then you can store that substring as a new string if you need to.
 //Found here https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID285
 //Under the Initializing an Empty String header.
 3. You can use the isEmpty property. If the string has characters in it this property will return false, if it's empty, it'll return true.
 //https://developer.apple.com/documentation/foundation/nsstring/1410120-components
 //https://developer.apple.com/documentation/foundation/nsstring/1413214-components
 4. CharacterSet, and String
 */









