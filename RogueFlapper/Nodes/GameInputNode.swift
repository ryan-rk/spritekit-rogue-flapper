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
    
    var gameInputComponentSystem = GKComponentSystem(componentClass: GameInputComponent.self)
    
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
        for component in gameInputComponentSystem.components {
            if let gameInputComponent = component as? GameInputComponent {
                if let currentView = scene?.view {
                    gameInputComponent.touchBegan(touches: touches, currentView: currentView)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for component in gameInputComponentSystem.components {
            if let gameInputComponent = component as? GameInputComponent {
                if let currentView = scene?.view {
                    gameInputComponent.touchMoved(touches: touches, currentView: currentView)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for component in gameInputComponentSystem.components {
            if let gameInputComponent = component as? GameInputComponent {
                if let currentView = scene?.view {
                    gameInputComponent.touchEnded(touches: touches, currentView: currentView)
                }
            }
        }
    }
        
}
