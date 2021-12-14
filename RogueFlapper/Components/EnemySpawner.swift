//
//  EnemySpawner.swift
//  RogueFlapper
//
//  Created by Ryan RK on 14/12/2021.
//

import SpriteKit
import GameplayKit

class EnemySpawner: GameComponent {
    
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
        enemy.component(ofType: NodeRenderer.self)?.node.position = CGPoint(x: randomHorizontalPos, y: randomVerticalPos)
        entityGameScene?.addEntity(entity: enemy)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
//        var numEnemy = 0
//        if let gameEntities = entityGameScene?.entities {
//            for entity in gameEntities {
//                if let nodeComponent = entity.component(ofType: NodeRenderer.self) {
//                    if nodeComponent.node.name == enemyType.rawValue + "EnemyNode" {
//                        numEnemy += 1
//                    }
//                }
//            }
//        }
//        if numEnemy >= maxSpawnEnemy {
//            canEnemyBeSpawn = false
//        } else {
//            canEnemyBeSpawn = true
//        }
    }
    
}
