//
//  HelperFunctions.swift
//  RogueFlapper
//
//  Created by Ryan RK on 28/10/2021.
//

import Foundation
import SpriteKit


func deg2rad(_ number: Double) -> Double {
    return number * .pi / 180
}


func splitLenIntoParts(len: Int, minPartLen: Int, maxPartLen: Int) -> [Range<Int>] {
    var splitParts = [Range<Int>]()
    var totalLen = 0
    var currentIndex = 0
    while totalLen < len {
        let randomLen = Int.random(in: minPartLen...maxPartLen)
        let clampedTopBound = min(totalLen + randomLen, len)
        
        if len - totalLen < minPartLen {
            let prevPart = splitParts.popLast()
            if let prevPart = prevPart {
                if len - prevPart.lowerBound > maxPartLen {
                    splitParts.append(prevPart.lowerBound ..< len - minPartLen)
                    splitParts.append(len - minPartLen ..< len)
                } else {
                    splitParts.append(prevPart.lowerBound ..< len)
                }
            }
        } else {
            splitParts.append(totalLen ..< clampedTopBound)
        }
        totalLen = clampedTopBound
        currentIndex += 1
    }
    return splitParts
}
