//
//  ScreenBound.swift
//  RogueFlapper
//
//  Created by Ryan RK on 24/10/2021.
//

import SpriteKit
import GameplayKit

class ScreenBound: GKEntity {
    
	// MARK:
	override init() {
        super.init()
        
        let nodeComponent = NodeComponent(nodeName: "ScreenBoundNode")
        addComponent(nodeComponent)
        
        let physicsComponent = PhysicsComponent(physicsBody: SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: 10, y: 10), size: UIProp.displaySize-CGSize(width: 20, height: 20))), colliderType: .Boundary)
        addComponent(physicsComponent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
