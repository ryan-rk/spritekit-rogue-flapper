//
//  NodeComponent.swift
//  RogueFlapper
//
//  Created by Ryan RK on 23/10/2021.
//

import SpriteKit
import GameplayKit

class NodeComponent: GKComponent {

    // MARK: Properties
    
    let node = SKNode()
    var renderLayer = WorldLayer.world
    
    init(nodeName: String, renderLayer: WorldLayer = .world) {
        super.init()
        node.name = nodeName
        self.renderLayer = renderLayer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: GKComponent
    
    override func didAddToEntity() {
        node.entity = entity
    }
    
    override func willRemoveFromEntity() {
        node.entity = nil
    }
}
