//
//  StringGenerationUtil.swift
//  StringsTest
//
//  Created by Vadym Yankovskiy on 5/6/18.
//  Copyright © 2018 Vadym Yankovskiy. All rights reserved.
//

import Foundation

func generateStrings(length: CountableClosedRange<Int>, amount: CountableClosedRange<Int>) -> [String]{
    let amount = randomInt(with: amount)
    var result: [String] = []
    
    for _ in 1...amount {
        let length = randomInt(with: length)
        result.append(randomText(length: length))
    }
    
    return result
}

func randomInt(with range: CountableClosedRange<Int>) -> Int{
    return Int(arc4random_uniform(UInt32(range.count - range.lowerBound + 1))) + range.lowerBound
}

func randomText(length: Int, justLowerCase: Bool = false) -> String {
    var text = ""
    for _ in 1...length {
        var decValue = 0  // ascii decimal value of a character
        var charType = 3  // default is lowercase
        if justLowerCase == false {
            // randomize the character type
            charType =  Int(arc4random_uniform(4))
        }
        switch charType {
        case 1:  // digit: random Int between 48 and 57
            decValue = Int(arc4random_uniform(10)) + 48
        case 2:  // uppercase letter
            decValue = Int(arc4random_uniform(26)) + 65
        case 3:  // lowercase letter
            decValue = Int(arc4random_uniform(26)) + 97
        default:  // space character
            decValue = 32
        }
        // get ASCII character from random decimal value
        if let scalar = UnicodeScalar(decValue){
            let char = String(scalar)
            text = text + char
        }else{
            text = text + " "
        }
    }
    return text
}


