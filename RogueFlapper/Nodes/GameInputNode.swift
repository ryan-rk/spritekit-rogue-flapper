//
//  GameInputNode.swift
//  RogueFlapper
//
//  Created by Ryan RK on 24/10/2021.
//

import SpriteKit
import GameplayKit

class GameInputNode: SKNode {
    
    private var controlArea: SKSpriteNode
    
    var gameInputCompSys = GKComponentSystem(componentClass: GameInput.self)
    
    init(controlAreaSize: CGSize, controlAreaLocation: CGPoint) {
        controlArea = SKSpriteNode(color: .clear, size: controlAreaSize)
        super.init()
        self.isUserInteractionEnabled = true
        
        controlArea.position = controlAreaLocation
        addChild(controlArea)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for component in gameInputCompSys.components {
            if let gic = component as? GameInput {
                if let currentView = scene?.view {
                    gic.touchBegan(touches: touches, currentView: currentView)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for component in gameInputCompSys.components {
            if let gic = component as? GameInput {
                if let currentView = scene?.view {
                    gic.touchMoved(touches: touches, currentView: currentView)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for component in gameInputCompSys.components {
            if let gic = component as? GameInput {
                if let currentView = scene?.view {
                    gic.touchEnded(touches: touches, currentView: currentView)
                }
            }
        }
    }
        
}
