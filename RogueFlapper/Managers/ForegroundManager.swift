//
//  ForegroundManager.swift
//  RogueFlapper
//
//  Created by Ryan RK on 8/12/2021.
//

import SpriteKit
import GameplayKit

class ForegroundManager: GameEntity {
    
    var speedController: WorldSpeedController?

	// MARK: Initializer
    init(name: String = "Foreground") {
        super.init(name: name, renderLayer: .foreground)
        
        let foregroundBlock1 = ForegroundBlock()
        addChildNode(foregroundBlock1.tileMapNode)
//        nodeComponent.node.addChild(foregroundBlock1.tileMapNode)
        let foregroundBlock2 = ForegroundBlock()
        addChildNode(foregroundBlock2.tileMapNode)
//        nodeComponent.node.addChild(foregroundBlock2.tileMapNode)
//        let foregroundBlock1 = SKSpriteNode(color: .red, size: CGSize(width: 64, height: 64))
//        nodeComponent.node.addChild(foregroundBlock1)
//        let foregroundBlock2 = SKSpriteNode(color: .blue, size: CGSize(width: 64, height: 64))
//        nodeComponent.node.addChild(foregroundBlock2)
        
        let infScroll = InfScroll(scrollBlocks: [foregroundBlock1.tileMapNode,foregroundBlock2.tileMapNode])
        addComponent(infScroll)
//        speedController = WorldSpeedController()
        if let speedController = speedController {
            addComponent(speedController)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func start() {
        if let speedController = speedController {
            speedController.attachController()
        }
    }

}

class ForegroundBlock: SKNode {
    
    let tileDim = 32
    let blockLen = 12
    let minPartLen = 2
    let maxPartLen = 5
    
    let minHeight = 3
    let maxHeight = 5
    let baseHeight = 4
    let heightPadding = 2
    let widthPadding = 3
    var tileMapNode = SKNode()
//    var tileMapNode = SKSpriteNode(color: .red, size: CGSize(width: 10*32, height: 7*32))
    
    override init() {
        super.init()
        
        
        let splitPartsTop = splitLenIntoParts(len: blockLen, minPartLen: minPartLen, maxPartLen: maxPartLen)
        let tileMapNodeTop = createTileMapNode(mapArray: creatHeightMap(splitParts: splitPartsTop))
        tileMapNodeTop.anchorPoint = CGPoint(x: 0, y: 0.3)
        tileMapNodeTop.yScale = -1
        tileMapNodeTop.position = CGPoint(x: 0, y: UIProp.displaySize.height - 16)
        
        let splitPartsBottom = splitLenIntoParts(len: blockLen, minPartLen: minPartLen, maxPartLen: maxPartLen)
        let tileMapNodeBottom = createTileMapNode(mapArray: creatHeightMap(splitParts: splitPartsBottom))
        tileMapNodeBottom.anchorPoint = CGPoint(x: 0, y: 0.3)
        
        tileMapNode.addChildren([tileMapNodeTop, tileMapNodeBottom])
    }
    
    func creatHeightMap(splitParts: [Range<Int>]) -> [[Int]] {

        var outputArr = Array(repeating: Array(repeating: 0, count: blockLen + 2*widthPadding), count: maxHeight + 2*heightPadding)
        for j in 0 ..< widthPadding {
            for k in heightPadding ..< baseHeight + heightPadding {
                outputArr[k][j] = 1
            }
        }
        for i in 0 ..< splitParts.count {
            let randHeight = Int.random(in: minHeight ... maxHeight)
            let partRange = splitParts[i]
            for j in partRange.lowerBound + widthPadding ..< partRange.upperBound + widthPadding {
                for k in heightPadding ..< randHeight + heightPadding {
                    outputArr[k][j] = 1
                }
            }
        }
        if let lastUpperBound = splitParts.last?.upperBound {
            for j in lastUpperBound + widthPadding ..< lastUpperBound + 2*widthPadding {
                for k in heightPadding ..< baseHeight + heightPadding {
                    outputArr[k][j] = 1
                }
            }
        }
        
        return outputArr
    }
    
    func createTileMapNode(mapArray: [[Int]]) -> SKTileMapNode {
        let tileset = SKTileSet(named: "Foreground Tileset")!
        let numCol = mapArray[0].count
        let numRow = mapArray.count
        let tilemapNode = SKTileMapNode(tileSet: tileset, columns: numCol, rows: numRow, tileSize: CGSize(width: tileDim, height: tileDim))
        tilemapNode.enableAutomapping = true
        
        for row in 0 ..< numRow {
            for col in 0 ..< numCol {
                if mapArray[row][col] > 0 {
                    tilemapNode.setTileGroup(tileset.tileGroups.first!, forColumn: col, row: row)
                }
            }
        }
        return tilemapNode
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
