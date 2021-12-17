//
//  Background.swift
//  RogueFlapper
//
//  Created by Ryan RK on 31/10/2021.
//

import SpriteKit
import GameplayKit

class Background: GameEntity {
    
    var zposOffset: CGFloat = 0
    
    // settings for infinite scrolling
    var isInfScroll = false
    var scrollBlocks: [SKNode] = []
    var baseScrollSpeed: CGFloat = 150
    var speedController: WorldSpeedController?

	// MARK: Initializer
    init(imageName: String, zposOffset: CGFloat, isInfScroll: Bool, name: String = "Background") {
        super.init(name: name, renderLayer: .background)
        self.zposOffset = zposOffset
        self.isInfScroll = isInfScroll
        
        zPos = zposOffset
        
        for _ in 0...(isInfScroll ? 2 : 1) {
            let spriteNode = SKSpriteNode(imageNamed: imageName)
            spriteNode.anchorPoint = .zero
            scrollBlocks.append(spriteNode)
            addChildNode(spriteNode)
        }

        if isInfScroll {
            let infScroll = InfiniteScroller(scrollBlocks: self.scrollBlocks, speed: baseScrollSpeed, speedScale: zposOffset)
            addComponent(infScroll)
            speedController = WorldSpeedController()
            if let speedController = speedController {
                addComponent(speedController)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func start() {
        if let speedController = speedController {
            speedController.attachController()
        }
//        if let levelScene = gameScene as? LevelScene {
//            for componentSystem in levelScene.componentSystems {
//                componentSystem.addComponent(foundIn: self)
//            }
//        }
//        if let levelScene = gameScene as? StartMenuScene {
//            for componentSystem in levelScene.componentSystems {
//                componentSystem.addComponent(foundIn: self)
//            }
//        }
    }

}
