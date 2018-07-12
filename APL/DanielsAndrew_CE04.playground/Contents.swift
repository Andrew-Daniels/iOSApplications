

import UIKit

/*
 Andrew Daniels
 APL-L 1711
 */

/* Part 1: Dictionary Declarations */
//Create a dictionary using Strings for the Key and Bools for the Value
var dictOne: [String: Bool] = ["Key1": true, "Key2": false, "Key3": false]
//Create an empty dictionary using String for the Key and Doubles for the Value
var dictTwo: [String: Double] = [String:Double]()
//Create a Dictionary using Strings for the Key and Optional Ints for the Value
var dictThree: [String: Int?] = ["Key1": 5, "Key2": 6, "Key3": nil]
//Create an empty Dictionary using String for the Key and Tuples with 3 different types for the value
var dictFour: [String: (Int, Float, Double)] = [String: (Int, Float, Double)]()
//Create a Dictionary using Strings for the Key and Arrays of Strings for the Value
var dictFive: [String: [String]] = ["Key1": ["1", "2"], "Key2": ["3", "4"], "Key3": ["5", "6"]]

/* Part 2: Optional Declarations */

//Declare an Optional Double Explicitly and give it a value in the declaration.
var optionalOne: Double? = 5
//Declare an Optional String Explicitly with no value.
var optionalTwo: String?
//Declare an Optional Tuple with 4 elements: Int, String, Optional String, and Bool and give it a value in the declaration
var optionalThree: (Int, String, String?, Bool)? = (5, "Hi", nil, false)
//Declare an Array of Optional Arrays of Optional Ints
var optionalFour: [[Int?]?] = [[5], [nil], nil]

/* Part 3: Random Values Dictionary */

//Declare an Array
var keysToSearch = ["Key_00", "Key_01", "Orange", "Key_153", "Key_05", "Key_10", "Key_25", "Key_15", "Portal", "Key_20"]

//Create a function that returns a Dictionary with a String for key and a random Int (0-100) for value
func createDict() -> [String: Int]
{
    //Declare an empty dictionary
    var newDict: [String: Int] = [String: Int]()
    
    //Add elements to the Dictionary
    //With a Key_## as the key
    //and a number 0-100 for the value
    for index in 0...25 {
    if index < 10 {
        newDict["Key_0\(index)"] = Int(arc4random_uniform(101))
    }
    else{
        newDict["Key_\(index)"] = Int(arc4random_uniform(101))
    }
    
}
    //return the newly created Dictionary with added elements
    return newDict
}

//create a dictionary equal to the randomly created dictionary created with the creatDict() method
var dict: [String: Int] = createDict()
print(dict)

//Cycle through every element inside the keysToSearch array
for keys in keysToSearch {
    if let oldValue = dict[keys]
    {
        //When the value from the key is an even number, set it's value to 0 and print old value
        if oldValue % 2 == 0
        {
        print("The old value of \(keys) is: \(oldValue)")
        dict.updateValue(0, forKey: "\(keys)")
        
        }
        //When the value from the key is an odd number, remove the element from the dictionary
        else if oldValue % 2 == 1
        {
            
            dict[keys] = nil
        }
    }
    else {
        //If the key from the array is not found in the dictionary, print out message to console.
        print("Key \(keys) not found.")
    }
}

print(dict)


var newDict = ["United States": [["Virginia": 500], ["Iowa", 300]]]

//newDict["United States"] = [["China" : 3000]]
print(newDict)


