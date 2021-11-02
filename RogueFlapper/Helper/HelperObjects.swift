//
//  HelperObjects.swift
//  RogueFlapper
//
//  Created by Ryan RK on 23/10/2021.
//

import UIKit

// MARK: - Structs

struct UIProp {
    static var displaySize = UIScreen.main.bounds.size
    static var displayCenter: CGPoint {
        CGPoint(x: displaySize.width/2, y: displaySize.height/2)
    }
}

struct PhysicsCategory {
    static let all              : UInt32 = UInt32.max
    static let none             : UInt32 = 0b0
    static let boundary         : UInt32 = 0b1 << 1
    static let player           : UInt32 = 0b1 << 2
}



// MARK: - Enums

enum ZLayer: Int {
    case background = 0
    case player = 10
}

/// The names and z-positions of each layer in a level's world.
enum WorldLayer: CGFloat {
    
    // Newly added layer is required to be added for allLayers and nodeName properties
    case background = -10
    case world = 0
    case interactable = 10
    case foreground = 20
    case gameInput = 30
    case ui = 40
    
    static var allLayers = [background, world, interactable, foreground, gameInput, ui]
    
    var nodeName: String {
        switch self {
        case .background: return "background"
        case .world: return "world"
        case .interactable: return "interactable"
        case .foreground: return "foreground"
        case .gameInput: return "gameInput"
        case .ui: return "ui"
        }
    }
}


