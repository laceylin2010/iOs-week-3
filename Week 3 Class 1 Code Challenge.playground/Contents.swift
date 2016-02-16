//: Playground - noun: a place where people can play

import UIKit

//this is a shorthand to count the words in a sting.

//
//func wordsInSentence(string: String) -> ()
//{
//    
//    let firstSentence = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).componentsSeparatedByString(" ")
//    firstSentence.count
//    
//}
//
//wordsInSentence("I love Starbucks ")



func wordsInSentence(string: String) -> Int
{
    
    var charArray = string.characters

    let word = string.characters.filter { (character) -> Bool in
        
        
        if charArray.last == " " {
            charArray.removeLast()

            return false //the return false does not work. I thought this would work but not sure why it is not.
            
        } else {
           
            return character == " "
        }
       
    }
   return word.count + 1
}

wordsInSentence("I like pens")













