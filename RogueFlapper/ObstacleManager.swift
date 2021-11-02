//
//  ObstacleManager.swift
//  RogueFlapper
//
//  Created by Ryan RK on 31/10/2021.
//

import SpriteKit
import GameplayKit

class ObstacleManager: GKEntity {
    
    var scrollBlocks: [SKNode] = []
    
    override init() {
        super.init()
        
        let nodeComponent = NodeComponent(nodeName: "ObstacleManagerNode", renderLayer: .interactable)
        addComponent(nodeComponent)
        
        let obstacleBlock1 = ObstacleBlock()
        scrollBlocks.append(obstacleBlock1)
        nodeComponent.node.addChild(obstacleBlock1)
        let obstacleBlock2 = ObstacleBlock()
        scrollBlocks.append(obstacleBlock2)
        nodeComponent.node.addChild(obstacleBlock2)
        
        let infScrollComponent = InfScrollComponent(scrollBlocks: scrollBlocks, blocksGap: UIProp.displaySize.width * 1.2, speed: 100)
        addComponent(infScrollComponent)
        infScrollComponent.repositionCallback = {(block: SKNode) in
            if let obstacleBlock = block as? ObstacleBlock {
                obstacleBlock.arrangeObstacles()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


class ObstacleBlock: SKNode {
    
    let blockHeight = UIProp.displaySize.height - 64
    var partPadding: CGFloat {
        return blockHeight / 20 }
    var partSizeMinThres: CGFloat {
        return blockHeight / 5 }
    var partSizeMaxThres: CGFloat {
        return blockHeight / 4 }
    let obstacleSize = CGSize(width: 64, height: 64)
    var obstacleMinGap: CGFloat {
        return GameplayConf.Player.playerSize.height*2 + obstacleSize.height*2 }
    
    override init() {
        super.init()
        arrangeObstacles()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func arrangeObstacles() {
        // remove all previous children before adding new obstacle
        removeAllChildren()
        // split obstacle block into parts
        var totalPartsLen: CGFloat = partPadding
        var partsRanges: [Range<CGFloat>] = []
        
        while totalPartsLen < (blockHeight-partPadding) {
            let randomPartSize = CGFloat.random(in: partSizeMinThres ... partSizeMaxThres)
            if (blockHeight-partPadding) - totalPartsLen <= partSizeMinThres {
                let prevPartRange = partsRanges.popLast()
                if let prevPartLowerBound = prevPartRange?.lowerBound {
                    partsRanges.append(prevPartLowerBound ..< (blockHeight-partPadding))
                }
                totalPartsLen = (blockHeight-partPadding)
            } else {
                partsRanges.append(totalPartsLen ..< (totalPartsLen + randomPartSize))
                totalPartsLen += randomPartSize
            }
        }
        
        // assure that obstacle block is partitioned into at least 3 parts
        if partsRanges.count < 3 {
            print("less than 3 parts, ranges configuration error!")
        }
        
        // add obstaclee to each part
        var prevObstaclePos: CGFloat = .zero
        for part in 0 ..< partsRanges.count {
            let obstacleNode = SKSpriteNode(color: .brown, size: .zero)
            let randomPosition = CGFloat.random(in: partsRanges[part])
            if part == 0 {
                obstacleNode.size = CGSize(width: obstacleSize.width, height: randomPosition + obstacleSize.height/2)
                obstacleNode.position = CGPoint(x: 0, y: (randomPosition + obstacleSize.height/2)/2)
                prevObstaclePos = randomPosition
            } else if part == (partsRanges.count - 1) {
                let clampedPos = max(randomPosition, (prevObstaclePos+obstacleMinGap))
                obstacleNode.size = CGSize(width: obstacleSize.width, height: blockHeight - clampedPos + obstacleSize.height/2)
                obstacleNode.position = CGPoint(x: 0, y: (blockHeight+(clampedPos - obstacleSize.height/2))/2)
                prevObstaclePos = clampedPos
            } else {
                let clampedPos = max(randomPosition, (prevObstaclePos+obstacleMinGap))
                obstacleNode.size = obstacleSize
                obstacleNode.position = CGPoint(x: 0, y: clampedPos)
                prevObstaclePos = clampedPos
            }
            addChild(obstacleNode)
            
        }
    }
}
