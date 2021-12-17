//
//  ObstacleTiles.swift
//  RogueFlapper
//
//  Created by Ryan RK on 27/11/2021.
//

import SpriteKit
import GameplayKit

class ObstacleTiles: GameEntity {
    
    let pbPadding = CGSize(width: 8, height: 8)

	// MARK: Initializer
    init(obstacleWidth: Int, obstacleHeight: Int, tileSize: CGSize, name: String = "Obstacle Tiles") {
        super.init(name: name, renderLayer: .interactable)
        
        let tileRenderer = TileRenderer(tileImageSet: "grass-tile", numCol: obstacleWidth, numRow: obstacleHeight, tileSize: tileSize)
        addComponent(tileRenderer)
        
        let physicsBody = PhysicsBody(body: SKPhysicsBody(rectangleOf: CGSize(width: tileSize.width * CGFloat(obstacleWidth), height: tileSize.height * CGFloat(obstacleHeight)) - pbPadding, center: CGPoint(x: tileSize.width * CGFloat(obstacleWidth)/2, y: tileSize.height * CGFloat(obstacleHeight)/2)), colliderType: .Obstacle)
        physicsBody.body.affectedByGravity = false
        addComponent(physicsBody)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
