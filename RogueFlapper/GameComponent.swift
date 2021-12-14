//
//  GameComponent.swift
//  RogueFlapper
//
//  Created by Ryan RK on 14/12/2021.
//

import SpriteKit
import GameplayKit

class GameComponent: GKComponent {
    
    var isActive: Bool {
        return (entity != nil) ? true : false
    }
    
    func setActive(in entity: GameEntity) {
        if !isActive {
            entity.addComponent(self)
        }
    }
    
    func setInactive() {
        entity?.removeComponent(ofType: type(of: self))
    }
    
}
