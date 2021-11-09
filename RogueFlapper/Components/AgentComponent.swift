//
//  AgentComponent.swift
//  RogueFlapper
//
//  Created by Ryan RK on 7/11/2021.
//

import SpriteKit
import GameplayKit

class AgentComponent: GKAgent2D {
    
    var agentBehavior: GKBehavior

    init(agentBehavior: GKBehavior) {
        self.agentBehavior = agentBehavior
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        self.behavior = agentBehavior
        self.mass = 1
        self.maxAcceleration = 50
        self.maxSpeed = 50
        self.radius = 20
        self.speed = 40
        
        self.delegate = entityNode
        
    }

}
