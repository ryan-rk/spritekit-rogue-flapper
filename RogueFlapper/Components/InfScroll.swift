//
//  InfScroll.swift
//  RogueFlapper
//
//  Created by Ryan RK on 30/10/2021.
//

import SpriteKit
import GameplayKit

class InfScroll: GKComponent {
    
    var scrollSpeed: CGFloat = 0
    var bgTrailingPos: CGFloat = 0
    var scrollBlocks: [SKNode] = []
    var blocksGap: CGFloat = .zero
    
    var repositionCallback = {(block: SKNode) in }
    
	// MARK: Initializer
    init(scrollBlocks: [SKNode], initialPosOffset: CGFloat = 0, blocksGap: CGFloat, speed: CGFloat) {
        super.init()
        
        self.scrollBlocks = scrollBlocks
        bgTrailingPos = initialPosOffset
        self.blocksGap = blocksGap
        scrollSpeed = speed
        
        for block in scrollBlocks {
            positionBlockToTrailing(block: block)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollBlock(block: SKNode, by amount: CGFloat) {
        let scrollAction = SKAction.move(by: CGVector(dx: amount, dy: 0), duration: 0)
        block.run(scrollAction)
    }
    
    func positionBlockToTrailing(block: SKNode) {
        block.position.x = bgTrailingPos
        bgTrailingPos += block.calculateAccumulatedFrame().width + blocksGap
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        bgTrailingPos += (-scrollSpeed * seconds)
        for block in scrollBlocks {
            scrollBlock(block: block, by: -scrollSpeed * seconds)
            if block.position.x <= -(block.calculateAccumulatedFrame().width + blocksGap) {
                positionBlockToTrailing(block: block)
                repositionCallback(block)
            }
        }
    }
    
}
