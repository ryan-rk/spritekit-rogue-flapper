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
    
    func getEntity() -> GameEntity {
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

class Enemy: GameEntity {
    
    let spriteRenderer = SpriteRenderer(spriteNode: SKSpriteNode(color: .gray, size: GameplayConf.Enemy.enemySize))
    let enemyMovement = EnemyMovement()

	// MARK: Initializer
    init(nodeSize: CGSize, name: String = "Enemy") {
        super.init(name: name, renderLayer: .interactable)
        
        addComponent(spriteRenderer)
        let physicsBody = PhysicsBody(body: SKPhysicsBody(rectangleOf: spriteRenderer.spriteNode.size+CGSize(width: 8, height: 8)), colliderType: .Enemy)
        addComponent(physicsBody)
        physicsBody.body.affectedByGravity = false
        physicsBody.setContactsInteractions(contactObjects: [.Player, .Projectile])
        
        addComponent(enemyMovement)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func removeEnemy() {
        gameScene?.removeEntity(entity: self)
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
        if let entityPosition = targetEntity.component(ofType: NodeRenderer.self)?.node.position {
            let chasingAction = SKAction.move(to: entityPosition, duration: speed)
            entityNode?.run(chasingAction)
        }
    }
}


// MARK: - Enemy subclasses
// MARK: Bee Enemy

class BeeEnemy: Enemy {
    
    init() {
        super.init(nodeSize: GameplayConf.Enemy.beeEnemySize, name: "Bee Enemy")
        spriteRenderer.spriteNode.color = .red
        
        enemyMovement.moveby(pos: CGVector(dx: 0, dy: UIProp.displaySize.height-300), speed: 100) { [unowned self] in
            gameScene?.removeEntity(entity: self)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: Spider Enemy

class SpiderEnemy: Enemy {
    
    init() {
        super.init(nodeSize: GameplayConf.Enemy.spiderEnemySize, name: "Spider Enemy")
        spriteRenderer.spriteNode.color = .green
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: Mosquito Enemy

class MosquitoEnemy: Enemy {
    
    let agentComponent = AgentComponent()
    
    init() {
        super.init(nodeSize: GameplayConf.Enemy.mosquitoEnemySize, name: "Mosquito Enemy")
        spriteRenderer.spriteNode.color = .blue
        
        addComponent(agentComponent)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func start() {
        var interceptGoal: GKGoal {
            guard let levelScene = gameScene as? LevelScene else {
                return GKGoal(toWander: 1.0)
            }
            return GKGoal(toInterceptAgent: levelScene.player.agent, maxPredictionTime: 1.0)
        }
        agentComponent.agentGoals.append(interceptGoal)
        agentComponent.goalsWeights = [0.1,100]
        agentComponent.updateBehavior()
    }
}
