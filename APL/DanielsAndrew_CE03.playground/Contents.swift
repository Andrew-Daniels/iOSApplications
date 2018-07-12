/*
 Andrew Daniels
 APL-L 1711
 */

import UIKit

/* Intermediate Functions */

/* 1. */
func NoParaBoolReturn() -> Bool
{
    let randomNumber = arc4random_uniform(2)
    if randomNumber == 0
    {
        return true
    }
    else
    {
        return false
    }
}

/* 2. */
func TwoParaStringReturn(paraOne: Bool, paraTwo: String) -> String
{
    if paraOne == true
    {
        return paraTwo.uppercased()
    }
    else
    {
        return paraTwo.lowercased()
    }
}

print(TwoParaStringReturn(paraOne: NoParaBoolReturn(), paraTwo: "oNe"))
print(TwoParaStringReturn(paraOne: NoParaBoolReturn(), paraTwo: "TwO"))
print(TwoParaStringReturn(paraOne: NoParaBoolReturn(), paraTwo: "tHrEe"))

/* 3. */
func NoParaReturn() -> [Int]
{
    var arrayWithNumbers: [Int] = []
    while arrayWithNumbers.count < 10
    {
        let randomNum = Int(arc4random_uniform(100) + 1)
        arrayWithNumbers.append(randomNum)
    }
    return arrayWithNumbers
}


var newArray = NoParaReturn()
print(newArray)

/* 4. */
func ArrayOfIntTupleReturn(array: [Int]) -> (Int, Int, Double)
{
    var smallest = 0
    var largest = 0
    var median: Double = 0
    var arrayToReturn: [Int] = []
    for number in array
    {
        if smallest == 0
        {
            smallest = number
        }
        if number > largest
        {
            largest = number
        }
        if number < smallest
        {
            smallest = number
        }
        
        
        arrayToReturn.append(number)
        arrayToReturn.sort()
    }
    if arrayToReturn.count % 2 == 0
    {
        //print("Divisible by 2")
        let index1 = arrayToReturn.count / 2
        let index2 = arrayToReturn.count / 2 + 1
        median = Double((arrayToReturn[index1] + arrayToReturn[index2])) / Double(2)
        
    }
    else
    {
        //print("Not divisible by 2")
        let index = arrayToReturn.count / 2
        median = Double(arrayToReturn[index])
    }
    let numbers = (smallest, largest, median)
    return numbers
}

let(smallest, largest, median) = (ArrayOfIntTupleReturn(array: newArray))

print("The largest value found was \(largest), the smallest value found was \(smallest), and the median value found was \(median)")

/* 5. */
func SwitchRangeOperator(array: [Int])
{
    var firstCase = 0
    var secondCase = 0
    var thirdCase = 0
    for integer in array
    {
    switch integer
        {
        case 1...33:
            firstCase += 1
        case 34...66:
            secondCase += 1
        case 67...100:
            thirdCase += 1
        default:
            print("Out of Range/Error")
        }
    }
    print("The first case was hit \(firstCase) times, the second case was hit \(secondCase) times, and the third case was hit \(thirdCase) times.")
}

SwitchRangeOperator(array: newArray)


