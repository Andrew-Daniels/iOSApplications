/*
 Andrew Daniels
 APL-L 1711
 */


import UIKit


/* Part 1: Simple Functions */
func NoParametersAndNoReturn()
{
    print("Hi my name is Andrew")
}

NoParametersAndNoReturn()

func IntAsParameter(integer: Int) -> String
{
    return ("The Int that was passed into this function was \(integer).")
}

print(IntAsParameter(integer: 5))

/* Part 2: Random Int Array Function */
func NoParametersNoReturn()
{
    var greaterThanTen: Int = 0
    var exactlyTen = 0
    var lessThanTen = 0
    let randInt: [Int] =  [2, 5, 7, 8, 11, 20, 6, 4, 13, 10]
    
    for number in randInt
    {
        if number > 10
        {
            greaterThanTen += 1
        }
        if number == 10
        {
            exactlyTen += 1
        }
        if number < 10
        {
            lessThanTen += 1
        }
    }
    print("The random array of Ints is as follows: ", randInt)
    print("greater than 10: \(greaterThanTen), exactly ten: \(exactlyTen), less than ten: \(lessThanTen).")
}

NoParametersNoReturn()

/* Part 3: Nested Arrays Function */

var arrayOfArraysOfDoubles: [[Double]] = [[1.1, 2.2, 3.3, 4.4, 5.5], [6.6, 7.7, 8.8, 9.9, 1.2], [1.3, 1.4, 1.5, 1.6, 1.7]]

func ArrayofArraysOfDoublesString(doubles: [[Double]]) -> String
{
    var stringOfDoubles = ""
    
    for item in doubles
    {
        for number in item
        {
            stringOfDoubles += (String(number) + " ")
        }
    }
    return stringOfDoubles
}

print(ArrayofArraysOfDoublesString(doubles: arrayOfArraysOfDoubles))


