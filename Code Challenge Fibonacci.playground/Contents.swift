//: Playground - noun: a place where people can play

import UIKit

func fibonacciNumbers()
{
    var firstNumb = 0
    var secondNumb = 1
    
    for var i=0; i<100; i++
    {
        let fNumbers = firstNumb + secondNumb
        
        firstNumb = secondNumb
        
        secondNumb = fNumbers
        
        print(fNumbers)
        
    }
}

fibonacciNumbers()

