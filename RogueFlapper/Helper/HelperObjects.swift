//
//  HelperObjects.swift
//  RogueFlapper
//
//  Created by Ryan RK on 23/10/2021.
//

import UIKit

// MARK: - Structs

struct UIProp {
//    static var displaySize = UIScreen.main.bounds.size
    static var displaySize = CGSize(width: 414, height: 896)
    static var displayCenter: CGPoint {
        CGPoint(x: displaySize.width/2, y: displaySize.height/2)
    }
}





// MARK: - Enums

enum Layout: String {
    case center
    case top
    case bottom
    case left
    case right
}
