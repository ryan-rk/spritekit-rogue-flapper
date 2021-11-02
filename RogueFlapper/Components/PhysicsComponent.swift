//
//  PhysicsComponent.swift
//  RogueFlapper
//
//  Created by Ryan RK on 23/10/2021.
//

import SpriteKit
import GameplayKit

class PhysicsComponent: GKComponent {

    // MARK: Properties
    
    var physicsBody: SKPhysicsBody
    
    // MARK: Initializers
    
    init(physicsBody: SKPhysicsBody, colliderType: ColliderType) {
        self.physicsBody = physicsBody
        self.physicsBody.categoryBitMask = colliderType.categoryMask
        self.physicsBody.collisionBitMask = colliderType.collisionMask
        self.physicsBody.contactTestBitMask = colliderType.contactMask
        super.init()
        
    }
    
    override func didAddToEntity() {
        // attach physics body to entity node component's node
        entityNode?.physicsBody = physicsBody
    }
    
    override func willRemoveFromEntity() {
        // remove physics body from entity node component's node
        entityNode?.physicsBody = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
