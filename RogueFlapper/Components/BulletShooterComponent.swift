//
//  BulletShooterComponent.swift
//  RogueFlapper
//
//  Created by Ryan RK on 27/10/2021.
//

import SpriteKit
import GameplayKit

class BulletShooterComponent: GKComponent, GameInputHandler {
    var bulletSpeed: CGFloat = 600
    var bulletDirection: CGFloat = 270
    
	// MARK: Initializer
	override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func shoot(from pos: CGPoint, direction: CGVector, withSpeed: CGFloat) {
        let bullet = Bullet()
        if let bulletNode = bullet.component(ofType: NodeComponent.self)?.node {
            bulletNode.position = pos
            // add bullet to world node
            gameScene?.addEntity(entity: bullet)
        }
        bullet.component(ofType: PhysicsComponent.self)?.physicsBody.velocity = direction * withSpeed
    }
    
    // MARK: - Input handler
    
    func touchEnded(touches: Set<UITouch>, currentView: SKView) {
        if let gic = entity?.component(ofType: GameInputComponent.self) {
            let timeFromStart = gic.touchCurrentTime - gic.touchStartTime
            let posFromStart = gic.touchCurrentPos - gic.touchStartPos
            let distFromStart = hypotf(Float(posFromStart.x), Float(posFromStart.y))
            if (timeFromStart < gic.quickTapThresInterval) && (distFromStart < gic.quickTapThresRadius) {
                if let entityNode = entityNode {
                    let bulletStartPos = entityNode.position - CGPoint(x: 0, y: GameplayConf.Player.playerSize.height)
                    shoot(from: bulletStartPos, direction: CGVector(angle: deg2rad(bulletDirection)), withSpeed: bulletSpeed)
                }
            }
        }
    }
}
