//
//  Enemy.swift
//  RogueFlapper
//
//  Created by Ryan RK on 28/10/2021.
//

import SpriteKit
import GameplayKit

class Enemy: GKEntity {

	// MARK: Initializer
	override init() {
        super.init()
        
        let nodeComponent = NodeComponent(nodeName: "EnemyNode", renderLayer: .interactable)
        addComponent(nodeComponent)
        
        let renderComponent = RenderComponent(visualNode: SKSpriteNode(color: .red, size: GameplayConf.Enemy.enemySize))
        addComponent(renderComponent)
        
        setPhysicsInteraction()
        let physicsComponent = PhysicsComponent(physicsBody: SKPhysicsBody(rectangleOf: GameplayConf.Enemy.enemySize+CGSize(width: 8, height: 8)), colliderType: .Enemy)
        addComponent(physicsComponent)
        physicsComponent.physicsBody.affectedByGravity = false
        
        let chasingComponent = ChasingComponent()
        addComponent(chasingComponent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setPhysicsInteraction() {
        ColliderType.addContactNotificationsList(responder: .Enemy, contacts: [.Player, .Projectile])
    }

}

extension Enemy: ContactNotifiableType {
    func contactWithEntityDidBegin(_ entity: GKEntity) {
        if entity is Bullet {
            print("bullet shot enemy")
            if let gameScene = component(ofType: NodeComponent.self)?.node.scene as? GameScene {
                gameScene.removeEntity(entity: self)
            }
        }
        if entity is Player {
            print("player contacted enemy")
        }
    }
    
    func contactWithEntityDidEnd(_ entity: GKEntity) {
    }
}


class ChasingComponent: GKComponent {
    
    func startChasing(targetEntity: GKEntity, speed: Double) {
        if let entityPosition = targetEntity.component(ofType: NodeComponent.self)?.node.position {
            let chasingAction = SKAction.move(to: entityPosition, duration: speed)
            entityNode?.run(chasingAction)
        }
    }
}
