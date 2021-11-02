//
//  GameScene.swift
//  RogueFlapper
//
//  Created by Ryan RK on 23/10/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var worldLayerNodes = [WorldLayer: SKNode]()
    var entities = Set<GKEntity>()
    
    let player = Player()
//    let screenBound = ScreenBound()
//    let enemyManager = EnemyManager()
    let bgManager = BgManager()
    let obstacleManager = ObstacleManager()
    
    lazy var componentSystems: [GKComponentSystem] = {
        let infScrollComponentSystem = GKComponentSystem(componentClass: InfScrollComponent.self)
        let gameInputComponentSystem = GKComponentSystem(componentClass: GameInputComponent.self)
        return [infScrollComponentSystem, gameInputComponentSystem]
    }()
    
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -4)
        //physicsWorld.gravity = .zero
        
        loadWorldLayers()
        bgManager.addEntities(to: self)
//        addEntity(entity: screenBound)
//        spawnPlayer(location: UIProp.displayCenter)
        addEntity(entity: obstacleManager)
//        addEntity(entity: enemyManager)
//        attachGameInputNode()
        
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
//        for entity in self.entities {
//            entity.update(deltaTime: dt)
//        }
        
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
            componentSystem.componentClass == GameInputComponent.self
        }){
            gameInputNode.gameInputComponentSystem = gameInputComponentSystem
        }
        addNode(node: gameInputNode, toWorldLayer: .gameInput)
    }
    
    
    // MARK: - Helper functions
    
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