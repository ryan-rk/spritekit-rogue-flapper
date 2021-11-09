//
//  SKNode+.swift
//  RogueFlapper
//
//  Created by Ryan RK on 7/11/2021.
//

import SpriteKit
import GameplayKit

extension SKNode {
    
    func addChildExt(_ node: SKNode) {
        addChild(node)
        node.didAddToParent(parent: self)
    }
    
    func didAddToParent(parent: SKNode) {
        
    }
    
}

extension SKNode: GKAgentDelegate {
    
    // update agent position to match node position
    public func agentWillUpdate(_ agent: GKAgent) {
        guard let agent = agent as? GKAgent2D else {
            return
        }
        
        agent.position = vector_float2(x: Float(position.x), y: Float(position.y))
    }
    
    // update node position to match agent position
    public func agentDidUpdate(_ agent: GKAgent) {
        guard let agent = agent as? GKAgent2D else {
            return
        }
        
        position = CGPoint(x: CGFloat(agent.position.x), y: CGFloat(agent.position.y))
    }
}
