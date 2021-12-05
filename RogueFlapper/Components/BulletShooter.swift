//
//  BulletShooter.swift
//  RogueFlapper
//
//  Created by Ryan RK on 27/10/2021.
//

import SpriteKit
import GameplayKit

class BulletShooter: GKComponent, GameInputHandler {
    var bulletSpeed: CGFloat = 600
    var bulletDirection: CGFloat = 270
    
	// MARK: Initializer
	override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func shootBullet() {
        let bullet = Bullet()
        gameScene?.addEntity(entity: bullet)
        if let entityNode = entityNode {
            let bulletStartPos = entityNode.position
            bullet.shoot(from: bulletStartPos, direction: CGVector(angle: deg2rad(bulletDirection)), withSpeed: bulletSpeed)
        }
    }
    
    // MARK: - Input handler
    
    func touchEnded(touches: Set<UITouch>, currentView: SKView) {
        if let gic = entity?.component(ofType: GameInput.self) {
            let timeFromStart = gic.touchCurrentTime - gic.touchStartTime
            let posFromStart = gic.touchCurrentPos - gic.touchStartPos
            let distFromStart = hypotf(Float(posFromStart.x), Float(posFromStart.y))
            if (timeFromStart < gic.quickTapThresInterval) && (distFromStart < gic.quickTapThresRadius) {
                shootBullet()
            }
        }
    }
}
