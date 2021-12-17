//
//  ObstacleManager.swift
//  RogueFlapper
//
//  Created by Ryan RK on 31/10/2021.
//

import SpriteKit
import GameplayKit

class ObstacleManager: GameEntity {
    
    var scrollBlocks: [SKNode] = []
//    var obstacleBlockOffset = 8
    var speedController: WorldSpeedController?
    
    init(name: String = "Obstacle Manager") {
        super.init(name: name, renderLayer: .interactable)
        
        let obstacleBlock1 = ObstacleBlock()
//        obstacleBlock1.position += CGPoint(x: 0, y: obstacleBlockOffset)
        scrollBlocks.append(obstacleBlock1)
        addChildNode(obstacleBlock1)
//        nodeComponent.node.addChild(obstacleBlock1)
        let obstacleBlock2 = ObstacleBlock()
//        obstacleBlock2.position += CGPoint(x: 0, y: obstacleBlockOffset)
        scrollBlocks.append(obstacleBlock2)
        addChildNode(obstacleBlock2)
//        nodeComponent.node.addChild(obstacleBlock2)
        
        let infScroll = InfiniteScroller(scrollBlocks: scrollBlocks, initialPosOffset: UIProp.displaySize.width * 1.2, blocksGap: UIProp.displaySize.width * 1.2)
        addComponent(infScroll)
        infScroll.repositionCallback = {(block: SKNode) in
            if let obstacleBlock = block as? ObstacleBlock {
                obstacleBlock.arrangeObstacles()
            }
        }
        speedController = WorldSpeedController()
        if let speedController = speedController {
            addComponent(speedController)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func start() {
        if let speedController = speedController {
            speedController.attachController()
        }
    }
    
}


class ObstacleBlock: SKNode {
    
    let tileDim = 32
    let obstacleBlockOffset: CGFloat = 8
    var blockHeight: Int {
        return Int((UIProp.displaySize.height - (obstacleBlockOffset*2))/CGFloat(tileDim)) }
    var partPadding = 3
    var partSizeMinThres: Int {
        return (blockHeight / 5) }
    var partSizeMaxThres: Int {
        return (blockHeight / 4) }
    let obstacleWidth = 3
    let obstacleHeight = 3
    var obstacleMinGap: Int {
        return Int(GameplayConf.Player.playerSize.height * 1.5 / CGFloat(tileDim)) + obstacleHeight }
    
    override init() {
        super.init()
//        print("block height: \(blockHeight)")
//        print("part padding: \(partPadding)")
//        print("part min thres: \(partSizeMinThres)")
//        print("part max thres: \(partSizeMaxThres)")
        arrangeObstacles()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func arrangeObstacles() {
        // remove all previous children before adding new obstacle
        removeAllChildren()
        // split obstacle block into parts
        var totalPartsLen = partPadding
        var partsRanges: [Range<Int>] = []
        
        while totalPartsLen < (blockHeight-partPadding) {
            let randomPartSize = Int.random(in: partSizeMinThres ... partSizeMaxThres)
            if (blockHeight-partPadding) - totalPartsLen < partSizeMinThres {
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
        var prevObstaclePos = 0
//        print("count: \(partsRanges.count)")
        print("ranges: \(partsRanges)")
//        print("block height: \(blockHeight)")
//        print("min thres: \(partSizeMinThres), max thres: \(partSizeMaxThres)")
        for part in 0 ..< partsRanges.count {
            var obstacleParts = [SKNode]()
//            var obstacleTiles = [SKSpriteNode]()
//            let obstacleNode = SKSpriteNode(color: .brown, size: .zero)
            let randomPosition = Int.random(in: partsRanges[part])
//            print("random position: \(randomPosition)")
            if part == 0 {
//                for i in 0 ..< obstacleWidth {
//                    for j in 0 ..< randomPosition {
//                        let obstacleTile = SKSpriteNode(color: .brown, size: CGSize(width: tileDim, height: tileDim))
//                        obstacleTile.anchorPoint = .zero
//                        obstacleTile.position = CGPoint(x: i * tileDim, y: j * tileDim)
//                        obstacleTiles.append(obstacleTile)
//                    }
//                }
                let obstacleTiles = ObstacleTiles(obstacleWidth: obstacleWidth, obstacleHeight: randomPosition, tileSize: CGSize(width: tileDim, height: tileDim))
                if let obstacleTilesNode = obstacleTiles.component(ofType: NodeRenderer.self)?.node {
                    obstacleParts.append(obstacleTilesNode)
                }
                prevObstaclePos = randomPosition
//                obstacleNode.size = CGSize(width: obstacleSize.width, height: CGFloat(tileSize * randomPosition) + obstacleSize.height/2)
//                obstacleNode.position = CGPoint(x: 0, y: (CGFloat(tileSize * randomPosition) + obstacleSize.height/2)/2)
//                prevObstaclePos = tileSize * randomPosition
            } else if part == (partsRanges.count - 1) {
                let clampedPos = max( randomPosition, (prevObstaclePos+obstacleMinGap))
//                for i in 0 ..< obstacleWidth {
//                    for j in 0 ..< (blockHeight - clampedPos) {
//                        let obstacleTile = SKSpriteNode(color: .brown, size: CGSize(width: tileDim, height: tileDim))
//                        obstacleTile.anchorPoint = .zero
//                        obstacleTile.position = CGPoint(x: i * tileDim, y: (j + clampedPos) * tileDim)
//                        obstacleTiles.append(obstacleTile)
//                    }
//                }
                let obstacleTiles = ObstacleTiles(obstacleWidth: obstacleWidth, obstacleHeight: (blockHeight - clampedPos), tileSize: CGSize(width: tileDim, height: tileDim))
                if let obstacleTilesNode = obstacleTiles.component(ofType: NodeRenderer.self)?.node {
                    obstacleTilesNode.position.y = CGFloat(clampedPos * tileDim)
                    obstacleParts.append(obstacleTilesNode)
                }
                prevObstaclePos = clampedPos
//                let clampedPos = max((tileSize * randomPosition), (prevObstaclePos+obstacleMinGap))
//                obstacleNode.size = CGSize(width: obstacleSize.width, height: CGFloat(tileSize * blockHeight - clampedPos) + obstacleSize.height/2)
//                obstacleNode.position = CGPoint(x: 0, y: (CGFloat(tileSize * blockHeight)+(CGFloat(clampedPos) - obstacleSize.height/2))/2)
//                prevObstaclePos = clampedPos
            } else {
                let clampedPos = max( randomPosition, (prevObstaclePos+obstacleMinGap))
//                for i in 0 ..< obstacleWidth {
//                    for j in 0 ..< obstacleHeight {
//                        let obstacleTile = SKSpriteNode(color: .brown, size: CGSize(width: tileDim, height: tileDim))
//                        obstacleTile.anchorPoint = .zero
//                        obstacleTile.position = CGPoint(x: i * tileDim, y: (j + clampedPos) * tileDim)
//                        obstacleTiles.append(obstacleTile)
//                    }
//                }
                let obstacleTiles = ObstacleTiles(obstacleWidth: obstacleWidth, obstacleHeight: obstacleHeight, tileSize: CGSize(width: tileDim, height: tileDim))
                if let obstacleTilesNode = obstacleTiles.component(ofType: NodeRenderer.self)?.node {
                    obstacleTilesNode.position.y = CGFloat(clampedPos * tileDim)
                    obstacleParts.append(obstacleTilesNode)
                }
                prevObstaclePos = clampedPos
//                let clampedPos = max((tileSize * randomPosition), (prevObstaclePos+obstacleMinGap))
//                obstacleNode.size = obstacleSize
//                obstacleNode.position = CGPoint(x: 0, y: clampedPos)
//                prevObstaclePos = clampedPos
            }
//            addChild(obstacleNode)
            addChildren(obstacleParts)
//            for obstacleTile in obstacleTiles {
//                obstacleTile.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: tileDim, height: tileDim), center: CGPoint(x: tileDim/2, y: tileDim/2))
//                obstacleTile.physicsBody?.affectedByGravity = false
//                obstacleTile.physicsBody?.collisionBitMask = .zero
//            }
            
        }
    }
}
