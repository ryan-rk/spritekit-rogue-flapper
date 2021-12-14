//
//  BackgroundManager.swift
//  RogueFlapper
//
//  Created by Ryan RK on 30/10/2021.
//

import SpriteKit
import GameplayKit

class BackgroundManager: GameEntity {
    
//    var bgEntities = Set<GKEntity>()
    
    let nodePosYOffset = 16
    
	// MARK: Initializer
    init(name: String = "Background Manager") {
        super.init(name: name, renderLayer: .background)
        
        let background1 = Background(imageName: "jungleBg1", zposOffset: 0, isInfScroll: false)
        addChildEntity(background1)
//        bgEntities.insert(background1)
        let background2 = Background(imageName: "jungleBg2", zposOffset: 0.04, isInfScroll: true)
        addChildEntity(background2)
//        bgEntities.insert(background2)
        let background3 = Background(imageName: "jungleBg3", zposOffset: 0.1, isInfScroll: true)
        addChildEntity(background3)
//        bgEntities.insert(background3)
        let background4 = Background(imageName: "jungleBg4", zposOffset: 0.3, isInfScroll: true)
        addChildEntity(background4)
//        bgEntities.insert(background4)
        let background5 = Background(imageName: "jungleBg5", zposOffset: 1, isInfScroll: true)
        addChildEntity(background5)
//        bgEntities.insert(background5)
        for bgEntity in entities {
            bgEntity.position = CGPoint(x: 0, y: nodePosYOffset)
        }
    }
    
    override func start() {
//        for bgEntity in bgEntities {
//            if let backgroundNode = entity.component(ofType: NodeRenderer.self)?.node {
//                backgroundNode.position = CGPoint(x: 0, y: nodePosYOffset)
//                gameScene?.addEntity(entity: entity)
//            }
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
