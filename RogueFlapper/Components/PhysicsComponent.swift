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
    var colliderType: ColliderType
    
    // MARK: Initializers
    
    init(physicsBody: SKPhysicsBody, colliderType: ColliderType) {
        self.physicsBody = physicsBody
        self.colliderType = colliderType
        super.init()
        physicsBody.categoryBitMask = colliderType.categoryMask
        physicsBody.collisionBitMask = colliderType.collisionMask
        physicsBody.contactTestBitMask = colliderType.contactMask
        
    }
    
    override func didAddToEntity() {
        // attach physics body to entity node component's node
        entityNode?.physicsBody = physicsBody
    }
    
    override func willRemoveFromEntity() {
        // remove physics body from entity node component's node
        entityNode?.physicsBody = nil
    }
    
    func setBodyBitMasks() {
        physicsBody.categoryBitMask = colliderType.categoryMask
        physicsBody.collisionBitMask = colliderType.collisionMask
        physicsBody.contactTestBitMask = colliderType.contactMask
    }
    
    func setPhysicsInteractions(_ collisionSubject: ColliderType? = nil, collisionObjects: [ColliderType], _ contactSubject: ColliderType? = nil, contactObjects: [ColliderType]) {
        if let collisionSubject = collisionSubject {
            ColliderType.definedCollisions[collisionSubject] = collisionObjects
        } else {
            ColliderType.definedCollisions[self.colliderType] = collisionObjects
        }
        if let contactSubject = contactSubject {
            ColliderType.requestedContactNotifications[contactSubject] = contactObjects
        } else {
            ColliderType.requestedContactNotifications[self.colliderType] = contactObjects
        }
        setBodyBitMasks()
    }
    
    func setCollisionsInteractions(_ collisionSubject: ColliderType? = nil, collisionObjects: [ColliderType]) {
        if let collisionSubject = collisionSubject {
            ColliderType.definedCollisions[collisionSubject] = collisionObjects
        } else {
            ColliderType.definedCollisions[self.colliderType] = collisionObjects
        }
        setBodyBitMasks()
    }
    
    func setContactsInteractions(_ contactSubject: ColliderType? = nil, contactObjects: [ColliderType]) {
        if let contactSubject = contactSubject {
            ColliderType.requestedContactNotifications[contactSubject] = contactObjects
        } else {
            ColliderType.requestedContactNotifications[self.colliderType] = contactObjects
        }
        setBodyBitMasks()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
