//
//  RenderComponent.swift
//  RogueFlapper
//
//  Created by Ryan RK on 23/10/2021.
//

import SpriteKit
import GameplayKit

class RenderComponent: GKComponent {
    
    var visualNode: SKNode
    
	// MARK: Initializer
    /// accepting sknode in terms of SKSpriteNode, SKShapeNode and SKLabelNode that renders the node visually
    init(visualNode: SKNode) {
        self.visualNode = visualNode
        super.init()
        
    }
    
    override func didAddToEntity() {
        // add visual node to entity node component's node
        entityNode?.addChild(visualNode)
    }
    
    override func willRemoveFromEntity() {
        // remove visual node from entity node component's node
        visualNode.removeFromParent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions
    func setAnchor(as anchor: CGPoint) {
        // only set for sprite node
        if let nodeWithAnchor = visualNode as? SKSpriteNode {
            nodeWithAnchor.anchorPoint = anchor
        }
    }

}
