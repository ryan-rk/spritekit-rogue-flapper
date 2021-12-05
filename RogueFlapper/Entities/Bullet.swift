//
//  Bullet.swift
//  RogueFlapper
//
//  Created by Ryan RK on 28/10/2021.
//

import SpriteKit
import GameplayKit

class Bullet: GKEntity {
    
    let destroyTimer: Double = 0.2
    
    let nodeComponent = NodeComponent(nodeName: "BulletNode", renderLayer: .interactable)
    let physicsComponent = PhysicsComponent(physicsBody: SKPhysicsBody(rectangleOf: GameplayConf.Bullet.bulletSize), colliderType: .Projectile)
    
	// MARK: Initializer
	override init() {
        super.init()
        
        addComponent(nodeComponent)
        
        let renderComponent = SpriteRenderer(spriteNode: SKSpriteNode(color: .white, size: GameplayConf.Bullet.bulletSize))
        addComponent(renderComponent)
        
        addComponent(physicsComponent)
        physicsComponent.physicsBody.affectedByGravity = false
        physicsComponent.setContactsInteractions(contactObjects: [.Boundary])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Bullet {
    func destroy() {
        if let gameScene = self.component(ofType: NodeComponent.self)?.node.scene as? GameScene {
            gameScene.removeEntity(entity: self)
        }
    }
    
    func shoot(from pos: CGPoint, direction: CGVector, withSpeed speed: CGFloat) {
        nodeComponent.node.position = pos
        physicsComponent.physicsBody.velocity = direction * speed
        destroyCountdown()
    }
    
    func destroyCountdown() {
        let destroyAction = SKAction.run { [weak self] in self?.destroy() }
        let destroyCountdownAction = SKAction.sequence([SKAction.wait(forDuration: destroyTimer),
                                                       destroyAction])
        nodeComponent.node.run(destroyCountdownAction)
    }
}

extension Bullet: ContactNotifiableType {
    func contactWithEntityDidBegin(_ entity: GKEntity) {
        destroy()
    }
    
    func contactWithEntityDidEnd(_ entity: GKEntity) {
    }
}
