//
//  TestScene.swift
//  RogueFlapper
//
//  Created by Ryan RK on 12/12/2021.
//

import SpriteKit
import GameplayKit

class TestScene: GameScene {
    
    let testNode = TestNode()
    let testEntity = TestEntity()
    
    override init(size: CGSize) {
        super.init(size: size)
        print("init once")
        name = "Test Scene"
        addChild(testNode)
        testNode.name = "Test Node"
//        addEntity(entity: testEntity)
        enumerateChildNodes(withName: "//*") { node, _ in
            print(node.name ?? "no name")
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class TestNode: SKNode {
    
    override init() {
        super.init()
        let testSpriteNode = SKSpriteNode(color: .red, size: CGSize(width: 128, height: 128))
        testSpriteNode.name = "Test Sprite Node"
        addChild(testSpriteNode)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func start() {
        print("test node at \(self.scene?.name ?? "no name 1")")
    }
}

class TestEntity: GKEntity {
    
    let nodeComponent = NodeRenderer(nodeName: "Test Entity Node")
    
    override init() {
        super.init()
        addComponent(nodeComponent)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func start() {
        print("Node component in: \(nodeComponent.node.scene?.name ?? "no name 2")")
    }
}
