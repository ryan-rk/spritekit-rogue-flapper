//
//  Player.swift
//  RogueFlapper
//
//  Created by Ryan RK on 23/10/2021.
//

import SpriteKit
import GameplayKit

class Player: GKEntity {
    
    
	// MARK: Initializer
	override init() {
        super.init()
        
        let nodeComponent = NodeComponent(nodeName: "PlayerNode", renderLayer: .interactable)
        addComponent(nodeComponent)
        
        let renderComponent = RenderComponent(visualNode: SKSpriteNode(color: .cyan, size: GameplayConf.Player.playerSize))
        addComponent(renderComponent)
        
        setPhysicsInteraction()
        let physicsComponent = PhysicsComponent(physicsBody: SKPhysicsBody(rectangleOf: GameplayConf.Player.playerSize+CGSize(width: 16, height: 16)), colliderType: .Player)
        addComponent(physicsComponent)
        physicsComponent.physicsBody.allowsRotation = false
        
        let gameInputComponent = GameInputComponent()
        addComponent(gameInputComponent)
        
        let playerFlapComponent = PlayerFlapComponent()
        addComponent(playerFlapComponent)
        
        let bulletShooterComponent = BulletShooterComponent()
        addComponent(bulletShooterComponent)
        
        let playerMovementComponent = PlayerMovementComponent()
        addComponent(playerMovementComponent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setPhysicsInteraction() {
        ColliderType.addCollisionList(responder: .Player, colliders: [.Boundary])
    }
    
}
