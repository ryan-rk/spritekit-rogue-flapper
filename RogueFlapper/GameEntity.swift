//
//  GameEntity.swift
//  RogueFlapper
//
//  Created by Ryan RK on 14/12/2021.
//

import SpriteKit
import GameplayKit

class GameEntity: GKEntity {
    
    // MARK: Properties of entity
    let nodeRenderer: NodeRenderer
    var entities = Set<GameEntity>()
    
    var node: GameNode {
        return nodeRenderer.node
    }
    
    var position: CGPoint {
        get {
            return nodeRenderer.node.position
        }
        set {
            nodeRenderer.node.position = newValue
        }
    }
    
    var zPos: CGFloat {
        get {
            return nodeRenderer.node.zPosition
        }
        set {
            nodeRenderer.node.zPosition = newValue
        }
    }
    
    var gameScene: GameScene? {
        if let nodeRenderer = component(ofType: NodeRenderer.self)?.node {
            if let gameScene = nodeRenderer.scene as? GameScene {
                return gameScene
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

	// MARK: Initializer
    init(name: String, renderLayer: WorldLayer = .world) {
        nodeRenderer = NodeRenderer(nodeName: "\(name) Node", renderLayer: renderLayer)
        super.init()
        addComponent(nodeRenderer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods for game system
    
    func didAddToScene(scene: GameScene) {
        for entity in entities {
            entity.didAddToScene(scene: scene)
            scene.updateECSList(entity: entity, isAdd: true)
        }
        awake()
    }
    
    func didRemoveFromScene(scene: GameScene) {
        for entity in entities {
            entity.didRemoveFromScene(scene: scene)
            scene.updateECSList(entity: entity, isAdd: false)
        }
        onRemove()
    }
    
    func awake() {}
    
    func start() {}
    
    func onRemove() {}
    
    
    // MARK: - Methods to add children to entity
    
    func addChildNode(_ node: SKNode) {
        nodeRenderer.node.addChild(node)
    }
    
    func addChildNodes(_ nodes: [SKNode]) {
        nodeRenderer.node.addChildren(nodes)
    }
    
    func addChildEntity(_ entity: GameEntity) {
        nodeRenderer.node.addChild(entity.nodeRenderer.node)
        entities.insert(entity)
    }
    
    func addChildrenEntity(_ entities: [GameEntity]) {
        for entity in entities {
            nodeRenderer.node.addChild(entity.nodeRenderer.node)
            self.entities.insert(entity)
        }
    }
    
}
