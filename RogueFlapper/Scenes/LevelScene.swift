//
//  LevelScene.swift
//  RogueFlapper
//
//  Created by Ryan RK on 12/12/2021.
//

import SpriteKit
import GameplayKit


class LevelScene: GameScene {
    
    let level: Int
    let player = Player()
    let screenBound = ScreenBound()
//    let beeEnemyManager = EnemyManager(enemyType: .beeEnemy)
//    let mosquitoEnemyManager = EnemyManager(enemyType: .mosquitoEnemy)
//    let spiderEnemyManager = EnemyManager(enemyType: .spiderEnemy)
    let bgManager = BackgroundManager()
    let fgManager = ForegroundManager()
    let obstacleManager = ObstacleManager()
    
    private var lastUpdateTime : TimeInterval = 0
    
    init(level: Int = 1, size: CGSize) {
        self.level = level
        super.init(size: size)
        // Initialize component systems
        componentSystems = [
            GKComponentSystem(componentClass: WorldSpeedController.self),
            GKComponentSystem(componentClass: InfScroll.self),
            GKComponentSystem(componentClass: GameInput.self),
            GKComponentSystem(componentClass: EnemySpawner.self),
            GKComponentSystem(componentClass: AgentComponent.self)
        ]
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -8)
        addEntity(entity: bgManager)
        addEntity(entity: screenBound)
        spawnPlayer(location: UIProp.displayCenter)
        addEntity(entity: obstacleManager)
        addEntity(entity: fgManager)
//        beeEnemyManager.component(ofType: NodeComponent.self)?.node.position.y = 100
//        addEntity(entity: beeEnemyManager)
//        mosquitoEnemyManager.component(ofType: NodeComponent.self)?.node.position.y = UIProp.displaySize.height - 100
//        addEntity(entity: mosquitoEnemyManager)
//        spiderEnemyManager.component(ofType: NodeComponent.self)?.node.position.y = UIProp.displaySize.height - 100
//        addEntity(entity: spiderEnemyManager)
        attachGameInputNode()
    }
    
    required init?(coder: NSCoder) {
        self.level = 1
        super.init(coder: coder)
    }
    
    
    // MARK: - Functions for loading level
    
    func spawnPlayer(location: CGPoint) {
        let playerNode = player.component(ofType: NodeRenderer.self)?.node
        playerNode?.position = location
        addEntity(entity: player)
    }
    
    func attachGameInputNode() {
        let gameInputNode = GameInputNode(controlAreaSize: UIProp.displaySize - CGSize(width: 60, height: 60), controlAreaLocation: UIProp.displayCenter)
        if let gameInputComponentSystem = self.componentSystems.first(where: { componentSystem in
            componentSystem.componentClass == GameInput.self
        }){
            gameInputNode.gameInputCompSys = gameInputComponentSystem
        }
        addNode(node: gameInputNode, toWorldLayer: .gameInput)
    }
    
}
