//
//  PlayerMovement.swift
//  RogueFlapper
//
//  Created by Ryan RK on 28/10/2021.
//

import SpriteKit
import GameplayKit

class PlayerMovement: GKComponent, GameInputHandler {
    
    var movementSens: CGFloat = 60
    
	// MARK: Initializer
	override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func moveHorizontal(by amount: CGFloat) {
        entityNode?.physicsBody?.velocity.dx = movementSens*amount
    }
    
    func stopHorizontalMove() {
        entityNode?.physicsBody?.velocity.dx = .zero
    }
    
    
    // MARK: - Input handler
    func touchBegan(touches: Set<UITouch>, currentView: SKView) {
    }
    
    func touchMoved(amountFromPrev: CGVector, touches: Set<UITouch>, currentView: SKView) {
        moveHorizontal(by: amountFromPrev.dx)
    }
    
    func touchEnded(touches: Set<UITouch>, currentView: SKView) {
        entityNode?.physicsBody?.velocity.dx = .zero
    }
    
}
