//
//  AgentComponent.swift
//  RogueFlapper
//
//  Created by Ryan RK on 7/11/2021.
//

import SpriteKit
import GameplayKit

class AgentComponent: GKAgent2D {
    
    var agentGoals = [GKGoal(toWander: 1.0)]
    var goalsWeights: [NSNumber] = [100]
    var agentBehavior: GKBehavior {
        return GKBehavior(goals: agentGoals, andWeights: goalsWeights)
    }

    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        behavior = agentBehavior
        mass = 1
        maxAcceleration = 80
        maxSpeed = 80
        radius = 20
        speed = 50
        delegate = entityNode
    }
    
    func updateBehavior() {
        behavior = agentBehavior
    }

}
