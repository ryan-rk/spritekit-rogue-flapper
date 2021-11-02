//
//  InfScrollComponent.swift
//  RogueFlapper
//
//  Created by Ryan RK on 30/10/2021.
//

import SpriteKit
import GameplayKit

class InfScrollComponent: GKComponent {
    
    var scrollSpeed: CGFloat = 0
    var bgTrailingPos: CGPoint = .zero
    var scrollBlocks: [SKNode] = []
    var blocksGap: CGFloat = .zero
    
    var repositionCallback = {(block: SKNode) in }
    
	// MARK: Initializer
    init(scrollBlocks: [SKNode], blocksGap: CGFloat, speed: CGFloat) {
        super.init()
        
        self.scrollBlocks = scrollBlocks
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
        block.position = bgTrailingPos
        bgTrailingPos += CGPoint(x: block.calculateAccumulatedFrame().width + blocksGap, y: 0)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        bgTrailingPos += CGPoint(x: -scrollSpeed * seconds, y: 0)
        for block in scrollBlocks {
            scrollBlock(block: block, by: -scrollSpeed * seconds)
            if block.position.x <= -(block.calculateAccumulatedFrame().width + blocksGap) {
                positionBlockToTrailing(block: block)
                repositionCallback(block)
            }
        }
    }
    
}
