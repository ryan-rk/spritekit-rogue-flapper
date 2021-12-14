//
//  GKEntity+.swift
//  RogueFlapper
//
//  Created by Ryan RK on 14/11/2021.
//

import GameplayKit

extension GKEntity {
    
    var gameScene: GameScene? {
        if let nodeRenderer = component(ofType: NodeRenderer.self)?.node {
            if let gameScene = nodeRenderer.scene as? GameScene {
                return gameScene
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
     
    @objc func start() {
    }
    
}
