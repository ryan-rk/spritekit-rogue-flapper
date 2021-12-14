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

	// MARK: Initializer
    init(name: String, renderLayer: WorldLayer = .world) {
        nodeRenderer = NodeRenderer(nodeName: "\(name) Node", renderLayer: renderLayer)
        super.init()
        addComponent(nodeRenderer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
