//
//  Player.swift
//  RogueFlapper
//
//  Created by Ryan RK on 23/10/2021.
//

import SpriteKit
import GameplayKit

class Player: GameEntity {
    
    var speed: CGFloat = 200
    
    let agent: GKAgent2D
    
	// MARK: Initializer
    init(name: String = "Player") {
        agent = GKAgent2D()
        super.init(name: name, renderLayer: .interactable)
        
        agent.delegate = nodeRenderer.node
        
        let spriteRenderer = SpriteRenderer(spriteNode: SKSpriteNode(imageNamed: "chick-flap1"), size: GameplayConf.Player.playerSize)
        addComponent(spriteRenderer)
        
        let physicsBody = PhysicsBody(body: SKPhysicsBody(circleOfRadius: GameplayConf.Player.playerPbRadius), colliderType: .Player)
        addComponent(physicsBody)
        physicsBody.body.allowsRotation = false
        physicsBody.setCollisionsInteractions(collisionObjects: [.Boundary])
        
        let gameInput = GameInput()
        addComponent(gameInput)
        
        let playerFlap = PlayerFlap()
        addComponent(playerFlap)
        
//        let bulletShooter = BulletShooter()
//        addComponent(bulletShooter)
        
        let playerMovement = PlayerMovement()
        addComponent(playerMovement)
        
        let animator = Animator(texturePrefix: "chick-flap", texturesCount: 3)
        addComponent(animator)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        agent.update(deltaTime: seconds)
    }
    
}
