//
//  EnemyMovement.swift
//  RogueFlapper
//
//  Created by Ryan RK on 7/11/2021.
//

import SpriteKit
import GameplayKit

class EnemyMovement: GameComponent {

    func moveby(pos: CGVector, speed: Float, completionCallback: @escaping ()->()) {
        let moveLength = hypotf(Float(pos.dx), Float(pos.dy))
        let moveAction = SKAction.moveBy(x: pos.dx, y: pos.dy, duration: TimeInterval(moveLength/speed))
        let callbackAction = SKAction.run(completionCallback)
        entityNode?.run(SKAction.sequence([moveAction,callbackAction]), withKey: "EnemyMoveToAction")
    }

}
