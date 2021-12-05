//
//  EnemyManager.swift
//  RogueFlapper
//
//  Created by Ryan RK on 29/10/2021.
//

import SpriteKit
import GameplayKit

class EnemyManager: GKEntity {
    
    // MARK: Initializer
    init(enemyType: EnemyType) {
        super.init()
        let nodeName = enemyType.rawValue + "ManagerNode"
        let nodeComponent = NodeComponent(nodeName: nodeName)
        addComponent(nodeComponent)
        
        let renderComponent = SpriteRenderer(spriteNode: SKSpriteNode(color: .black, size: GameplayConf.Enemy.enemySize))
        addComponent(renderComponent)
        
        let enemySpawnerComponent = EnemySpawnerComponent(enemyType: enemyType)
        enemySpawnerComponent.enemySpawnPosXRange = 0...UIProp.displaySize.width
        enemySpawnerComponent.enemySpawnPosYRange = 0...0
        addComponent(enemySpawnerComponent)
        enemySpawnerComponent.startSpawning(forCount: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class EnemySpawnerComponent: GKComponent {
    
    let enemyType: EnemyType
    var enemySpawnInterval: Double = 5
    var enemySpawnPosXRange: ClosedRange<CGFloat> = 0...0
    var enemySpawnPosYRange: ClosedRange<CGFloat> = 0...0
    
    var maxSpawnEnemy = 5
    var canEnemyBeSpawn = true
    
    // MARK: Initializer
    init(enemyType: EnemyType) {
        self.enemyType = enemyType
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startSpawning(forCount count: Int) {
        print("start spawning enemy")
        let waitAction = SKAction.wait(forDuration: enemySpawnInterval)
        let enemySpawningAction = SKAction.run { [unowned self] in
            if self.canEnemyBeSpawn {
                self.spawnEnemy()
            }
        }
        let enemySpawningLoop = SKAction.sequence([enemySpawningAction,waitAction])
        if count == 0 {
            entityNode?.run(SKAction.repeatForever(enemySpawningLoop),withKey: "EnemySpawningAction")
        } else if count > 0 {
            entityNode?.run(SKAction.repeat(enemySpawningLoop, count: count),withKey: "EnemySpawningAction")
        } else {
            print("Please provide positive integer for enemy spawn count")
        }
    }
    
    func spawnEnemy() {
        let enemy = enemyType.getEntity()
        let randomHorizontalPos = CGFloat.random(in: enemySpawnPosXRange)
        let randomVerticalPos = entityNode?.position.y ?? 0
        enemy.component(ofType: NodeComponent.self)?.node.position = CGPoint(x: randomHorizontalPos, y: randomVerticalPos)
        gameScene?.addEntity(entity: enemy)
//        enemy.component(ofType: EnemyMovement.self)?.moveby(pos: CGVector(dx: 0, dy: 50), speed: 0.5)
//        if let gameScene = gameScene {
//            enemy.component(ofType: ChasingComponent.self)?.startChasing(targetEntity: gameScene.player, speed: 2)
//        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        var numEnemy = 0
        if let gameEntities = gameScene?.entities {
            for entity in gameEntities {
                if let nodeComponent = entity.component(ofType: NodeComponent.self) {
                    if nodeComponent.node.name == enemyType.rawValue + "EnemyNode" {
                        numEnemy += 1
                    }
                }
            }
        }
        if numEnemy >= maxSpawnEnemy {
            canEnemyBeSpawn = false
        } else {
            canEnemyBeSpawn = true
        }
    }
    
}
