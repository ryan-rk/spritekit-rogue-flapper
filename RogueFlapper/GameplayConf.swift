//
//  GameplayConf.swift
//  RogueFlapper
//
//  Created by Ryan RK on 23/10/2021.
//

import Foundation
import UIKit

struct GameplayConf {
    
    struct Player {
        static let playerSize = CGSize(width: 32, height: 32)
    }
    
    struct Bullet {
        static let bulletSize = CGSize(width: 16, height: 16)
    }
    
    struct Enemy {
        static let enemySize = CGSize(width: 32, height: 32)
    }
}
