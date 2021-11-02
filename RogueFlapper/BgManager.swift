//
//  BgManager.swift
//  RogueFlapper
//
//  Created by Ryan RK on 30/10/2021.
//

import SpriteKit
import GameplayKit

class BgManager {
    
    var entities = Set<GKEntity>()
    
	// MARK: Initializer
    init() {
        let background1 = Background(imageName: "jungleBg1", zposOffset: 0, isInfScroll: false, baseScrollSpeed: 0)
        entities.insert(background1)
        let background2 = Background(imageName: "jungleBg2", zposOffset: 0.2, isInfScroll: true, baseScrollSpeed: 20)
        entities.insert(background2)
        let background3 = Background(imageName: "jungleBg3", zposOffset: 0.6, isInfScroll: true, baseScrollSpeed: 20)
        entities.insert(background3)
        let background4 = Background(imageName: "jungleBg4", zposOffset: 1.8, isInfScroll: true, baseScrollSpeed: 20)
        entities.insert(background4)
        let background5 = Background(imageName: "jungleBg5", zposOffset: 5.4, isInfScroll: true, baseScrollSpeed: 20)
        entities.insert(background5)
    }
    
    func addEntities(to scene: SKScene) {
        for entity in entities {
            if let gameScene = scene as? GameScene {
                gameScene.addEntity(entity: entity)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
