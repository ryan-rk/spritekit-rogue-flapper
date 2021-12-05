//
//  GameScene.swift
//  RogueFlapper
//
//  Created by Ryan RK on 23/10/2021.
//

import SpriteKit
import GameplayKit

/// The names and z-positions of each layer in a level's world.
enum WorldLayer: CGFloat {
    
    // Newly added layer is required to be added for allLayers and nodeName properties
    case background = -10
    case world = 0
    case interactable = 10
    case foreground = 20
    case gameInput = 30
    case ui = 40
    
    static var allLayers = [background, world, interactable, foreground, gameInput, ui]
    
    var nodeName: String {
        switch self {
        case .background: return "background"
        case .world: return "world"
        case .interactable: return "interactable"
        case .foreground: return "foreground"
        case .gameInput: return "gameInput"
        case .ui: return "ui"
        }
    }
}


class GameScene: SKScene {
    
    var worldLayerNodes = [WorldLayer: SKNode]()
    var entities = Set<GKEntity>()
    
    let player = Player()
    let screenBound = ScreenBound()
//    let beeEnemyManager = EnemyManager(enemyType: .beeEnemy)
//    let mosquitoEnemyManager = EnemyManager(enemyType: .mosquitoEnemy)
//    let spiderEnemyManager = EnemyManager(enemyType: .spiderEnemy)
    let bgManager = BgManager()
    let obstacleManager = ObstacleManager()
    
    lazy var componentSystems: [GKComponentSystem] = {
        let infScrollCompSys = GKComponentSystem(componentClass: InfScroll.self)
        let gameInputCompSys = GKComponentSystem(componentClass: GameInput.self)
        let enemySpawnerCompSys = GKComponentSystem(componentClass: EnemySpawnerComponent.self)
        let agentCompSys = GKComponentSystem(componentClass: AgentComponent.self)
        return [infScrollCompSys, gameInputCompSys, enemySpawnerCompSys, agentCompSys]
    }()
    
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -8)
//        physicsWorld.gravity = .zero
        
        loadWorldLayers()
        bgManager.addEntities(to: self)
        addEntity(entity: screenBound)
        spawnPlayer(location: UIProp.displayCenter)
        addEntity(entity: obstacleManager)
//        beeEnemyManager.component(ofType: NodeComponent.self)?.node.position.y = 100
//        addEntity(entity: beeEnemyManager)
//        mosquitoEnemyManager.component(ofType: NodeComponent.self)?.node.position.y = UIProp.displaySize.height - 100
//        addEntity(entity: mosquitoEnemyManager)
//        spiderEnemyManager.component(ofType: NodeComponent.self)?.node.position.y = UIProp.displaySize.height - 100
//        addEntity(entity: spiderEnemyManager)
        attachGameInputNode()
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        // Update components
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    
    // MARK: - Load level
    
    func spawnPlayer(location: CGPoint) {
        let playerNode = player.component(ofType: NodeComponent.self)?.node
        playerNode?.position = location
        addEntity(entity: player)
    }
    
    func loadWorldLayers() {
        for worldLayer in WorldLayer.allLayers {
            let worldLayerNode = SKNode()
            worldLayerNode.name = worldLayer.nodeName
            worldLayerNode.zPosition = worldLayer.rawValue
            addChild(worldLayerNode)
            worldLayerNodes[worldLayer] = worldLayerNode
        }
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
    
    
    // MARK: - functions to manage entities and nodes
    
    func addNode(node: SKNode, toWorldLayer worldLayer: WorldLayer) {
        let worldLayerNode = worldLayerNodes[worldLayer]!
        worldLayerNode.addChild(node)
    }
    
    func addEntity(entity: GKEntity) {
        entities.insert(entity)
        
        for componentSystem in self.componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
        
        if let entityNodeComponent = entity.component(ofType: NodeComponent.self) {
            addNode(node: entityNodeComponent.node, toWorldLayer: entityNodeComponent.renderLayer)
            entity.didAddToScene()
        }
        
    }
    
    func removeEntity(entity: GKEntity) {
        entities.remove(entity)
        
        for componentSystem in self.componentSystems {
            componentSystem.removeComponent(foundIn: entity)
        }
        
        if let entityNode = entity.component(ofType: NodeComponent.self)?.node {
            entityNode.removeFromParent()
        }
    }
    
    
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        handleContact(contact: contact) { (ContactNotifiableType: ContactNotifiableType, otherEntity: GKEntity) in
            ContactNotifiableType.contactWithEntityDidBegin(otherEntity)
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        handleContact(contact: contact) { (ContactNotifiableType: ContactNotifiableType, otherEntity: GKEntity) in
            ContactNotifiableType.contactWithEntityDidEnd(otherEntity)
        }
    }
    

    private func handleContact(contact: SKPhysicsContact, contactCallback: (ContactNotifiableType, GKEntity) -> Void) {
        // Get the `ColliderType` for each contacted body.
        let colliderTypeA = ColliderType(rawValue: contact.bodyA.categoryBitMask)
        let colliderTypeB = ColliderType(rawValue: contact.bodyB.categoryBitMask)
        
        // Determine which `ColliderType` should be notified of the contact.
        let aWantsCallback = colliderTypeA.notifyOnContactWith(colliderTypeB)
        let bWantsCallback = colliderTypeB.notifyOnContactWith(colliderTypeA)
        
        // Make sure that at least one of the entities wants to handle this contact.
        assert(aWantsCallback || bWantsCallback, "Unhandled physics contact - A = \(colliderTypeA), B = \(colliderTypeB)")
        
        let entityA = contact.bodyA.node?.entity
        let entityB = contact.bodyB.node?.entity

        /*
            If `entityA` is a notifiable type and `colliderTypeA` specifies that it should be notified
            of contact with `colliderTypeB`, call the callback on `entityA`.
        */
        if let notifiableEntity = entityA as? ContactNotifiableType, let otherEntity = entityB, aWantsCallback {
            contactCallback(notifiableEntity, otherEntity)
        }
        
        /*
            If `entityB` is a notifiable type and `colliderTypeB` specifies that it should be notified
            of contact with `colliderTypeA`, call the callback on `entityB`.
        */
        if let notifiableEntity = entityB as? ContactNotifiableType, let otherEntity = entityA, bWantsCallback {
            contactCallback(notifiableEntity, otherEntity)
        }
    }
}
