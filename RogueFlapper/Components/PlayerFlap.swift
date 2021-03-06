//
//  PlayerFlapCOMP.swift
//  RogueFlapper
//
//  Created by Ryan RK on 27/10/2021.
//

import SpriteKit
import GameplayKit

class PlayerFlap: GameComponent, GameInputHandler {
    
    var playerFlapAmount: CGFloat = 30
    
    func playerFlap() {
        entityBody?.velocity = .zero
        entityBody?.applyImpulse(CGVector(dx: 0, dy: playerFlapAmount))
        let entityAnimator = entity?.component(ofType: Animator.self)
        entityAnimator?.animate(loopCount: 1, restoreOnEnd: true, timePerFrame: 0.1)
    }
    
    // MARK: - Input handler
    func touchEnded(touches: Set<UITouch>, currentView: SKView) {
        if let gic = entity?.component(ofType: GameInput.self) {
            let timeFromStart = gic.touchCurrentTime - gic.touchStartTime
            let posFromStart = gic.touchCurrentPos - gic.touchStartPos
            let distFromStart = hypotf(Float(posFromStart.x), Float(posFromStart.y))
            if (timeFromStart < gic.quickTapThresInterval) && (distFromStart < gic.quickTapThresRadius) {
                playerFlap()
            }
            
//            if let player = entity as? Player {
//                player.speed -= 20
////                entityNode?.removeAction(forKey: "Restore Action")
//                let restoreTimer = SKAction.wait(forDuration: 1)
//                let restoreAction = SKAction.sequence([restoreTimer, SKAction.run({
//                    player.speed += 20
//                })])
//                entityNode?.run(restoreAction)
//                print(player.speed)
//            }
        }
    }
    
}
