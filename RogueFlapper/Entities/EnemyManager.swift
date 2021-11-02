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
    override init() {
        super.init()
        let nodeComponent = NodeComponent(nodeName: "EnemyManagerNode")
        addComponent(nodeComponent)
        
        let enemySpawnerComponent = EnemySpawnerComponent()
        addComponent(enemySpawnerComponent)
        enemySpawnerComponent.startSpawning(forCount: 10)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class EnemySpawnerComponent: GKComponent {
    
    var canEnemyBeSpawn = true
    var enemySpawnInterval = 5
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startSpawning(forCount count: Int) {
        print("start spawning enemy")
        let waitAction = SKAction.wait(forDuration: 5)
        let enemySpawningAction = SKAction.run { [unowned self] in
            if self.canEnemyBeSpawn {
                self.spawnEnemy()
            }
        }
        let enemySpawningLoop = SKAction.sequence([waitAction,enemySpawningAction])
        if count == 0 {
            entityNode?.run(SKAction.repeatForever(enemySpawningLoop))
        } else if count > 0 {
            entityNode?.run(SKAction.repeat(enemySpawningLoop, count: count))
        } else {
            print("Please provide positive integer for enemy spawn count")
        }
    }
    
    func spawnEnemy() {
        let enemy = Enemy()
        let randomHorizontalPos = CGFloat.random(in: 0...UIProp.displaySize.width)
        enemy.component(ofType: NodeComponent.self)?.node.position = CGPoint(x: randomHorizontalPos, y: 0)
        gameScene?.addEntity(entity: enemy)
        if let gameScene = gameScene {
            enemy.component(ofType: ChasingComponent.self)?.startChasing(targetEntity: gameScene.player, speed: 2)
        }
    }
    
}
