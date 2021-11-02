//
//  Background.swift
//  RogueFlapper
//
//  Created by Ryan RK on 31/10/2021.
//

import SpriteKit
import GameplayKit

class Background: GKEntity {
    
    var zposOffset: CGFloat = 0
    
    // settings for infinite scrolling
    var isInfScroll = false
    var scrollBlocks: [SKNode] = []
    var baseScrollSpeed: CGFloat = 0

	// MARK: Initializer
    init(imageName: String, zposOffset: CGFloat, isInfScroll: Bool, baseScrollSpeed: CGFloat) {
        super.init()
        self.zposOffset = zposOffset
        self.isInfScroll = isInfScroll
        
        let nodeComponent = NodeComponent(nodeName: "Background", renderLayer: .background)
        addComponent(nodeComponent)
        nodeComponent.node.zPosition = zposOffset
        
        for _ in 0...2 {
            let spriteNode = SKSpriteNode(imageNamed: imageName)
            spriteNode.anchorPoint = .zero
            scrollBlocks.append(spriteNode)
            nodeComponent.node.addChild(spriteNode)
        }

        if isInfScroll {
            let infScrollComponent = InfScrollComponent(scrollBlocks: self.scrollBlocks, blocksGap: 0, speed: baseScrollSpeed * zposOffset)
            addComponent(infScrollComponent)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
