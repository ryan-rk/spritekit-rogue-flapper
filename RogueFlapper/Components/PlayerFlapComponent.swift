//
//  PlayerFlapComponent.swift
//  RogueFlapper
//
//  Created by Ryan RK on 27/10/2021.
//

import SpriteKit
import GameplayKit

class PlayerFlapComponent: GKComponent, GameInputHandler {
    
    var playerFlapAmount: CGFloat = 50
    
    func playerFlap() {
        entityBody?.velocity = .zero
        entityBody?.applyImpulse(CGVector(dx: 0, dy: playerFlapAmount))
    }
    
    // MARK: - Input handler
    func touchEnded(touches: Set<UITouch>, currentView: SKView) {
        if let gic = entity?.component(ofType: GameInputComponent.self) {
            let timeFromStart = gic.touchCurrentTime - gic.touchStartTime
            let posFromStart = gic.touchCurrentPos - gic.touchStartPos
            let distFromStart = hypotf(Float(posFromStart.x), Float(posFromStart.y))
            if (timeFromStart < gic.quickTapThresInterval) && (distFromStart < gic.quickTapThresRadius) {
                playerFlap()
            }
        }
    }
    
}
