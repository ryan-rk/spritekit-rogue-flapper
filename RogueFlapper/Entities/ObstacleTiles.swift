//
//  ObstacleTiles.swift
//  RogueFlapper
//
//  Created by Ryan RK on 27/11/2021.
//

import SpriteKit
import GameplayKit

class ObstacleTiles: GKEntity {
    
    let pbPadding = CGSize(width: 8, height: 8)

	// MARK: Initializer
    init(obstacleWidth: Int, obstacleHeight: Int, tileSize: CGSize) {
        super.init()
        
//        print("width: \(obstacleWidth), height: \(obstacleHeight), tileSize:\(tileSize)")
        
        let nodeComponent = NodeComponent(nodeName: "ObstacleTilesNode", renderLayer: .interactable)
        addComponent(nodeComponent)
        
//        let renderComponent = RenderComponent(spriteNode: SKSpriteNode(color: .red, size: CGSize(width: CGFloat(obstacleWidth) * tileSize.width, height: CGFloat(obstacleHeight) * tileSize.height)))
//        addComponent(renderComponent)
//        renderComponent.spriteNode.anchorPoint = .zero
        
        let tileRenderer = TileRenderer(tileImageSet: "grass-tile", numCol: obstacleWidth, numRow: obstacleHeight, tileSize: tileSize)
        addComponent(tileRenderer)
        
        let physicsComponent = PhysicsComponent(physicsBody: SKPhysicsBody(rectangleOf: CGSize(width: tileSize.width * CGFloat(obstacleWidth), height: tileSize.height * CGFloat(obstacleHeight)) - pbPadding, center: CGPoint(x: tileSize.width * CGFloat(obstacleWidth)/2, y: tileSize.height * CGFloat(obstacleHeight)/2)), colliderType: .Obstacle)
        physicsComponent.physicsBody.affectedByGravity = false
        addComponent(physicsComponent)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
