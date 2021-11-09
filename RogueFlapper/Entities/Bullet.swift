//
//  Bullet.swift
//  RogueFlapper
//
//  Created by Ryan RK on 28/10/2021.
//

import SpriteKit
import GameplayKit

class Bullet: GKEntity {
    
	// MARK: Initializer
	override init() {
        super.init()
        
        let nodeComponent = NodeComponent(nodeName: "BulletNode", renderLayer: .interactable)
        addComponent(nodeComponent)
        
        let renderComponent = RenderComponent(spriteNode: SKSpriteNode(color: .white, size: GameplayConf.Bullet.bulletSize))
        addComponent(renderComponent)
        
        let physicsComponent = PhysicsComponent(physicsBody: SKPhysicsBody(rectangleOf: GameplayConf.Bullet.bulletSize), colliderType: .Projectile)
        addComponent(physicsComponent)
        physicsComponent.physicsBody.affectedByGravity = false
        physicsComponent.setContactsInteractions(contactObjects: [.Boundary])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Bullet: ContactNotifiableType {
    func contactWithEntityDidBegin(_ entity: GKEntity) {
        if let gameScene = self.component(ofType: NodeComponent.self)?.node.scene as? GameScene {
            gameScene.removeEntity(entity: self)
        }
    }
    
    func contactWithEntityDidEnd(_ entity: GKEntity) {
    }
}
