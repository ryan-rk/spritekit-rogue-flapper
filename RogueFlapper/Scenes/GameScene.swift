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
    
    // MARK: - Variables and Constants
    
    var entities = Set<GameEntity>()
    var worldLayerNodes = [WorldLayer: SKNode]()
    lazy var componentSystems = [GKComponentSystem]()
    
    private var lastUpdateTime: TimeInterval = 0
    
    override init(size: CGSize) {
        super.init(size: size)
        loadWorldLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        startAllNodes()
    }
    
    func startAllNodes() {
        enumerateChildNodes(withName: "//*") { node, _ in
            node.start()
        }
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
    
    // MARK: - Functions to manage world layers
    
    func loadWorldLayers() {
        for worldLayer in WorldLayer.allLayers {
            let worldLayerNode = SKNode()
            worldLayerNode.name = worldLayer.nodeName
            worldLayerNode.zPosition = worldLayer.rawValue
            addChild(worldLayerNode)
            worldLayerNodes[worldLayer] = worldLayerNode
        }
    }
    
    // MARK: - Functions to manage entities and nodes
    
    func addNode(node: SKNode, toWorldLayer worldLayer: WorldLayer) {
        let worldLayerNode = worldLayerNodes[worldLayer]!
        worldLayerNode.addChild(node)
    }
    
    func addEntity(entity: GameEntity) {
        entities.insert(entity)
        
        for componentSystem in self.componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
        
        if let entityNode = entity.component(ofType: NodeRenderer.self) {
            addNode(node: entityNode.node, toWorldLayer: entityNode.renderLayer)
        }
        
    }
    
    func removeEntity(entity: GameEntity) {
        entities.remove(entity)
        
        for componentSystem in self.componentSystems {
            componentSystem.removeComponent(foundIn: entity)
        }
        
        if let entityNode = entity.component(ofType: NodeRenderer.self)?.node {
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
