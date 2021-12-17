//
//  NodeRenderer.swift
//  RogueFlapper
//
//  Created by Ryan RK on 23/10/2021.
//

import SpriteKit
import GameplayKit

class NodeRenderer: GameComponent {

    // MARK: Properties
    
    let node = GameNode()
    var renderLayer = WorldLayer.world
    
    init(nodeName: String, renderLayer: WorldLayer = .world) {
        super.init()
        node.name = nodeName
        self.renderLayer = renderLayer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: GKComponent methods
    
    override func didAddToEntity() {
        node.entity = entity
    }
    
    override func willRemoveFromEntity() {
        node.entity = nil
    }
}
