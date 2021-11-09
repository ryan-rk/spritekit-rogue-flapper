//
//  RenderComponent.swift
//  RogueFlapper
//
//  Created by Ryan RK on 23/10/2021.
//

import SpriteKit
import GameplayKit

class RenderComponent: GKComponent {
    
    var spriteNode: SKSpriteNode
    
	// MARK: Initializer
    /// accepting sknode in terms of SKSpriteNode, SKShapeNode and SKLabelNode that renders the node visually
    init(spriteNode: SKSpriteNode) {
        self.spriteNode = spriteNode
        super.init()
        
    }
    
    override func didAddToEntity() {
        // add visual node to entity node component's node
        entityNode?.addChild(spriteNode)
    }
    
    override func willRemoveFromEntity() {
        // remove visual node from entity node component's node
        spriteNode.removeFromParent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
