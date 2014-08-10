//
//  MathProblem.swift
//  Math Flash
//
//  Created by Steven Rosenberg on 8/4/14.
//  Copyright (c) 2014 Steven Rosenberg. All rights reserved.
//

import Foundation

class MathProblem {
    
    var topNumber:UInt32 = 0
    var bottomNumber:UInt32 = 0
    var answer = 0
    
    func additionProblem (level: Int) -> Array<Int> {
        switch level {
        case 1:
            topNumber = 9
            bottomNumber = 9
        case 2:
            topNumber = 19
            bottomNumber = 19
        case 3:
            topNumber = 49
            bottomNumber = 49
        case 4:
            topNumber = 99
            bottomNumber = 99
        default:
            break
        }
        var sequence : [Int] = []
        let randomNumberOne = Int(arc4random_uniform(topNumber)) + 1
        let randomNumberTwo = Int(arc4random_uniform(bottomNumber)) + 1
        answer = randomNumberOne + randomNumberTwo
        //array sequence is topNumber, bottomNumber, answer
        sequence.append(randomNumberOne)
        sequence.append(randomNumberTwo)
        sequence.append(answer)
        return sequence
    }
    
    func subtractionProblem (level: Int) -> Array<Int> {
        switch level {
        case 1:
            topNumber = 9
            bottomNumber = 9
        case 2:
            topNumber = 19
            bottomNumber = 19
        case 3:
            topNumber = 49
            bottomNumber = 49
        case 4:
            topNumber = 99
            bottomNumber = 99
        default:
            break
        }
        var sequence : [Int] = []
        let randomNumberOne = Int(arc4random_uniform(topNumber)) + 1
        let randomNumberTwo = Int(arc4random_uniform(bottomNumber)) + 1
        //insure larger number is on top
        //array sequence is larger number, smaller number, answer (no negative numbers)
        if randomNumberOne >= randomNumberTwo {
            sequence.append(randomNumberOne)
            sequence.append(randomNumberTwo)
            answer = randomNumberOne - randomNumberTwo
            sequence.append(answer)
        } else {
            sequence.append(randomNumberTwo)
            sequence.append(randomNumberOne)
            answer = randomNumberTwo - randomNumberOne
            sequence.append(answer)
        }
        return sequence
    }
    
    func multiplicationProblem (level: Int) -> Array<Int> {
        switch level {
        case 1:
            topNumber = 9
            bottomNumber = 5
        case 2:
            topNumber = 9
            bottomNumber = 9
        case 3:
            topNumber = 12
            bottomNumber = 12
        case 4:
            topNumber = 19
            bottomNumber = 12
        default:
            break
        }
        var sequence : [Int] = []
        let randomNumberOne = Int(arc4random_uniform(topNumber)) + 1
        let randomNumberTwo = Int(arc4random_uniform(bottomNumber)) + 1
        answer = randomNumberOne*randomNumberTwo
        //array sequence is topNumber, bottomNumber, answer
        sequence.append(randomNumberOne)
        sequence.append(randomNumberTwo)
        sequence.append(answer)
        return sequence
    }
    
    func divisionProblem (level: Int) -> Array<Int> {
        switch level {
        case 1:
            topNumber = 9
            bottomNumber = 5
        case 2:
            topNumber = 9
            bottomNumber = 9
        case 3:
            topNumber = 12
            bottomNumber = 12
        case 4:
            topNumber = 19
            bottomNumber = 12
        default:
            break
        }
        var sequence : [Int] = []
        let randomNumberOne = Int(arc4random_uniform(topNumber)) + 1
        let randomNumberTwo = Int(arc4random_uniform(bottomNumber)) + 1
        answer = randomNumberOne*randomNumberTwo
        //we perform a reverse multiplication.  For convenience leave topNumber, bottomNumber and answer in the same calculation sequence in this function as in other functions above.  We return an array with the multiplied number in the first position, then it does not matter which of the remaining numbers is the bottom number or the answer.
        sequence.append(answer)
        sequence.append(randomNumberTwo)
        sequence.append(randomNumberOne)
        return sequence
    }
    
}
