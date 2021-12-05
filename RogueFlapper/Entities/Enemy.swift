//
//  Enemy.swift
//  RogueFlapper
//
//  Created by Ryan RK on 28/10/2021.
//

import SpriteKit
import GameplayKit

enum EnemyType: String {
    case beeEnemy
    case spiderEnemy
    case mosquitoEnemy
    
    func getEntity() -> GKEntity {
        switch self {
        case .beeEnemy:
            return BeeEnemy()
        case .spiderEnemy:
            return SpiderEnemy()
        case .mosquitoEnemy:
            return MosquitoEnemy()
        }
    }
    
}

class Enemy: GKEntity {
    
    let nodeComponent = NodeComponent(nodeName: "EnemyNode", renderLayer: .interactable)
    let renderComponent = SpriteRenderer(spriteNode: SKSpriteNode(color: .gray, size: GameplayConf.Enemy.enemySize))
//    var physicsComponent: PhysicsComponent {
//        return PhysicsComponent(physicsBody: SKPhysicsBody(rectangleOf: renderComponent.spriteNode.size+CGSize(width: 8, height: 8)), colliderType: .Enemy)
//    }
    let enemyMovement = EnemyMovement()

	// MARK: Initializer
    init(nodeSize: CGSize) {
        super.init()
        
        addComponent(nodeComponent)
        addComponent(renderComponent)
        let physicsComponent = PhysicsComponent(physicsBody: SKPhysicsBody(rectangleOf: renderComponent.spriteNode.size+CGSize(width: 8, height: 8)), colliderType: .Enemy)
        addComponent(physicsComponent)
        physicsComponent.physicsBody.affectedByGravity = false
        physicsComponent.setContactsInteractions(contactObjects: [.Player, .Projectile])
        
        addComponent(enemyMovement)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func removeEnemy() {
        if let gameScene = component(ofType: NodeComponent.self)?.node.scene as? GameScene {
            gameScene.removeEntity(entity: self)
        }
    }
    
    deinit {
        print("enemy destroyed")
    }
    

}

extension Enemy: ContactNotifiableType {
    func contactWithEntityDidBegin(_ entity: GKEntity) {
        if entity is Bullet {
            print("bullet shot enemy")
            removeEnemy()
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


// MARK: - Enemy subclasses
// MARK: Bee Enemy

class BeeEnemy: Enemy {
    
    init() {
        super.init(nodeSize: GameplayConf.Enemy.beeEnemySize)
        nodeComponent.node.name = EnemyType.beeEnemy.rawValue + "EnemyNode"
        renderComponent.spriteNode.color = .red
        
        enemyMovement.moveby(pos: CGVector(dx: 0, dy: UIProp.displaySize.height-300), speed: 100) { [unowned self] in
            if let gameScene = self.nodeComponent.node.scene as? GameScene {
                gameScene.removeEntity(entity: self)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: Spider Enemy

class SpiderEnemy: Enemy {
    
    init() {
        super.init(nodeSize: GameplayConf.Enemy.spiderEnemySize)
        nodeComponent.node.name = EnemyType.spiderEnemy.rawValue + "EnemyNode"
        renderComponent.spriteNode.color = .green
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: Mosquito Enemy

class MosquitoEnemy: Enemy {
    
    let agentComponent = AgentComponent()
    
    init() {
        super.init(nodeSize: GameplayConf.Enemy.mosquitoEnemySize)
        nodeComponent.node.name = EnemyType.mosquitoEnemy.rawValue + "EnemyNode"
        renderComponent.spriteNode.color = .blue
        
        addComponent(agentComponent)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func didAddToScene() {
        var interceptGoal: GKGoal {
            guard let gameScene = nodeComponent.node.scene as? GameScene else {
                return GKGoal(toWander: 1.0)
            }
            return GKGoal(toInterceptAgent: gameScene.player.agent, maxPredictionTime: 1.0)
        }
        agentComponent.agentGoals.append(interceptGoal)
        agentComponent.goalsWeights = [0.1,100]
        agentComponent.updateBehavior()
    }
}
