//
//  GameInputComponent.swift
//  RogueFlapper
//
//  Created by Ryan RK on 24/10/2021.
//

import SpriteKit
import GameplayKit

class GameInputComponent: GKComponent {
    
    var quickTapThresRadius: Float = 5
    var quickTapThresInterval: Double = 0.25
    
    var isTouchDown = false
    var touchStartPos: CGPoint = .zero
    var touchStartTime: Double = .zero
    var touchCurrentPos: CGPoint = .zero
    var touchCurrentTime: Double = .zero
    
	// MARK: Initializer
	override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touchBegan(touches: Set<UITouch>, currentView: SKView) {
        isTouchDown = true
        touchStartTime = touches.first?.timestamp ?? .zero
        touchStartPos = touches.first?.location(in: currentView) ?? .zero
        touchCurrentTime = touchStartTime
        touchCurrentPos = touchStartPos
        
        if let entityComponents = entity?.components {
            for component in entityComponents {
                if let gameInputHandlingComponent = component as? GameInputHandler {
                    gameInputHandlingComponent.touchBegan(touches: touches, currentView: currentView)
                }
            }
        }
    }
    
    func touchMoved(touches: Set<UITouch>, currentView: SKView) {
        isTouchDown = true
        touchCurrentTime = touches.first?.timestamp ?? .zero
        touchCurrentPos = touches.first?.location(in: currentView) ?? .zero
        let touchPrevPos = touches.first?.previousLocation(in: currentView) ?? .zero
        
        if let entityComponents = entity?.components {
            for component in entityComponents {
                if let gameInputHandlingComponent = component as? GameInputHandler {
                    gameInputHandlingComponent.touchMoved(amountFromPrev:CGVector(point: touchCurrentPos-touchPrevPos), touches: touches, currentView: currentView)
                }
            }
        }
    }
    
    func touchEnded(touches: Set<UITouch>, currentView: SKView) {
        touchCurrentTime = touches.first?.timestamp ?? .zero
        touchCurrentPos = touches.first?.location(in: currentView) ?? .zero
        
        if let entityComponents = entity?.components {
            for component in entityComponents {
                if let gameInputHandlingComponent = component as? GameInputHandler {
                    gameInputHandlingComponent.touchEnded(touches: touches, currentView: currentView)
                }
            }
        }
        isTouchDown = false
    }
    
    override func update(deltaTime seconds: TimeInterval) {
    }

}
