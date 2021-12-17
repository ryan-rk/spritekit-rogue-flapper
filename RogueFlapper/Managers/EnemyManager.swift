//
//  EnemyManager.swift
//  RogueFlapper
//
//  Created by Ryan RK on 29/10/2021.
//

import SpriteKit
import GameplayKit

class EnemyManager: GameEntity {
    
    // MARK: Initializer
    init(enemyType: EnemyType, name: String = "Enemy Manager") {
        super.init(name: name)
        
        let spriteRenderer = SpriteRenderer(spriteNode: SKSpriteNode(color: .black, size: GameplayConf.Enemy.enemySize))
        addComponent(spriteRenderer)
        
        let enemySpawnerComponent = EnemySpawner(enemyType: enemyType)
        enemySpawnerComponent.enemySpawnPosXRange = 0...UIProp.displaySize.width
        enemySpawnerComponent.enemySpawnPosYRange = 0...0
        addComponent(enemySpawnerComponent)
        enemySpawnerComponent.startSpawning(forCount: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

