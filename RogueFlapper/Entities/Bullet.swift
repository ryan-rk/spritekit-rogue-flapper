//
//  Bullet.swift
//  RogueFlapper
//
//  Created by Ryan RK on 28/10/2021.
//

import SpriteKit
import GameplayKit

class Bullet: GameEntity {
    
    let destroyTimer: Double = 0.2
    
    let physicsBody = PhysicsBody(body: SKPhysicsBody(rectangleOf: GameplayConf.Bullet.bulletSize), colliderType: .Projectile)
    
	// MARK: Initializer
    init(name: String = "Bullet") {
        super.init(name: name, renderLayer: .interactable)
        
        let spriteRenderer = SpriteRenderer(spriteNode: SKSpriteNode(color: .white, size: GameplayConf.Bullet.bulletSize))
        addComponent(spriteRenderer)
        
        addComponent(physicsBody)
        physicsBody.body.affectedByGravity = false
        physicsBody.setContactsInteractions(contactObjects: [.Boundary])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Bullet {
    func destroy() {
        gameScene?.removeEntity(entity: self)
//        if let gameScene = self.component(ofType: NodeRenderer.self)?.node.scene as? GameScene {
//            gameScene.removeEntity(entity: self)
//        }
    }
    
    func shoot(from pos: CGPoint, direction: CGVector, withSpeed speed: CGFloat) {
        nodeRenderer.node.position = pos
        physicsBody.body.velocity = direction * speed
        destroyCountdown()
    }
    
    func destroyCountdown() {
        let destroyAction = SKAction.run { [weak self] in self?.destroy() }
        let destroyCountdownAction = SKAction.sequence([SKAction.wait(forDuration: destroyTimer),
                                                       destroyAction])
        nodeRenderer.node.run(destroyCountdownAction)
    }
}

extension Bullet: ContactNotifiableType {
    func contactWithEntityDidBegin(_ entity: GKEntity) {
        destroy()
    }
    
    func contactWithEntityDidEnd(_ entity: GKEntity) {
    }
}
