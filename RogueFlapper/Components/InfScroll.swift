//
//  InfScroll.swift
//  RogueFlapper
//
//  Created by Ryan RK on 30/10/2021.
//

import SpriteKit
import GameplayKit

class InfScroll: GameComponent, SpeedControllable {
    
    var controlledSpeed: CGFloat
    var speedScale: CGFloat
    var scrollSpeed: CGFloat { return speedScale * controlledSpeed }
    var blocksGap: CGFloat
    var bgTrailingPos: CGFloat
    var scrollBlocks: [SKNode] = []
    
    var repositionCallback = {(block: SKNode) in }
    
	// MARK: Initializer
    init(scrollBlocks: [SKNode], initialPosOffset: CGFloat = 0, blocksGap: CGFloat = 0, speed: CGFloat = 0, speedScale: CGFloat = 1) {
        bgTrailingPos = initialPosOffset
        self.controlledSpeed = speed
        self.speedScale = speedScale
        self.blocksGap = blocksGap
        self.scrollBlocks = scrollBlocks
        super.init()
        
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
