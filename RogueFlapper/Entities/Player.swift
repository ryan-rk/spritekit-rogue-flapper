//
//  Player.swift
//  RogueFlapper
//
//  Created by Ryan RK on 23/10/2021.
//

import SpriteKit
import GameplayKit

class Player: GKEntity {
    
    let agent: GKAgent2D
    
    
	// MARK: Initializer
	override init() {
        agent = GKAgent2D()
        super.init()
        
        let nodeComponent = NodeComponent(nodeName: "PlayerNode", renderLayer: .interactable)
        addComponent(nodeComponent)
        agent.delegate = nodeComponent.node
        
        let renderComponent = RenderComponent(spriteNode: SKSpriteNode(color: .cyan, size: GameplayConf.Player.playerSize))
        addComponent(renderComponent)
        
        let physicsComponent = PhysicsComponent(physicsBody: SKPhysicsBody(rectangleOf: GameplayConf.Player.playerSize+CGSize(width: 16, height: 16)), colliderType: .Player)
        addComponent(physicsComponent)
        physicsComponent.physicsBody.allowsRotation = false
        physicsComponent.setCollisionsInteractions(collisionObjects: [.Boundary])
        
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

    override func update(deltaTime seconds: TimeInterval) {
        agent.update(deltaTime: seconds)
    }
    
}
