//
//  GKComponent+.swift
//  RogueFlapper
//
//  Created by Ryan RK on 30/10/2021.
//

import GameplayKit

extension GKComponent {
    var entityNode: SKNode? {
        if let node = entity?.component(ofType: NodeRenderer.self)?.node {
            return node
        }
        return nil
    }
    
    var entityBody: SKPhysicsBody? {
        if let body = entity?.component(ofType: PhysicsBody.self)?.body {
            return body
        }
        return nil
    }
    
    var entityGameScene: GameScene? {
        if let gameEntity = entity as? GameEntity {
            if let gameScene = gameEntity.gameScene {
                return gameScene
            } else {
                return nil
            }
        }
        return nil
    }
    
//    var entityScene: SKScene? {
//        if let scene = entityNode?.scene {
//            return scene
//        }
//        return nil
//    }
//
//    var gameScene: GameScene? {
//        if let gameScene = entityScene as? GameScene {
//            return gameScene
//        }
//        return nil
//    }
}
