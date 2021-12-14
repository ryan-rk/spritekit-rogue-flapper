//
//  ScreenBound.swift
//  RogueFlapper
//
//  Created by Ryan RK on 24/10/2021.
//

import SpriteKit
import GameplayKit

class ScreenBound: GameEntity {
    
    init(name: String = "Screen Bound") {
        super.init(name: name, renderLayer: .world)
        
        let physicsBody = PhysicsBody(body: SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: 10, y: 10), size: UIProp.displaySize-CGSize(width: 20, height: 20))), colliderType: .Boundary)
        addComponent(physicsBody)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
