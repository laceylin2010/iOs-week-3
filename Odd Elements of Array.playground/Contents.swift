//: Playground - noun: a place where people can play

import UIKit


var numbers = [1,2,3,4,5,6,7,8,9,10]

func isOdd(i: Int) -> Bool {
    return i % 2 != 0
}

let number = numbers.filter(isOdd)

