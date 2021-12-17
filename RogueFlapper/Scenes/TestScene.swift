//
//  TestScene.swift
//  RogueFlapper
//
//  Created by Ryan RK on 12/12/2021.
//

import SpriteKit
import GameplayKit

class TestScene: GameScene {
    
    
    override init(size: CGSize) {
        super.init(size: size)
        name = "Test Scene"
//        let testEntity = TestEntity(name: "Test Entity")
//        addEntity(entity: testEntity)
        let testButton = Button(name: "Test Button")
        addEntity(entity: testButton)
        testButton.position = UIProp.displayCenter
        let testButton2 = Button(name: "Test Button")
        addEntity(entity: testButton2)
        testButton2.position = CGPoint(x: 256, y: 128)
        let sp3 = SKSpriteNode(color: .cyan, size: UIProp.displaySize)
        addChild(sp3)
        sp3.zPosition = -1
        sp3.position = UIProp.displayCenter
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class TestEntity: GameEntity, Clickable {
    func touchDown() {
        print("touch down")
    }
    
    func clicked() {
        print("clicked")
    }
    
    func clickCancelled() {
        print("clicked cancelled")
    }
    
    
    init(name: String) {
        super.init(name: name)
        position = UIProp.displayCenter
        
        let spc = SpriteRenderer(spriteNode: SKSpriteNode(color: .red, size: CGSize(width: 128, height: 128)))
        addComponent(spc)
        let sp2 = SKSpriteNode(color: .blue, size: CGSize(width: 64, height: 64))
        addChildNode(sp2)
        let testNode = TestNode()
        addChildNode(testNode)
        
        let click = ClickListener()
        addComponent(click)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TestNode: SKNode {
    override init() {
        super.init()
        let sp1 = SKSpriteNode(color: .red, size: CGSize(width: 64, height: 64))
        sp1.position = CGPoint(x: 0, y: -200)
        addChild(sp1)
        let sp2 = SKSpriteNode(color: .green, size: CGSize(width: 64, height: 64))
        sp2.position = CGPoint(x: 0, y: 100)
        addChild(sp2)
        let sp3 = SKSpriteNode(color: .blue, size: CGSize(width: 64, height: 64))
        sp3.position = CGPoint(x: 0, y: 300)
        addChild(sp3)
        print("finish adding all testnode children")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touched")
//
//        guard let touch = touches.first else {
//            return
//        }
//
//        let location = touch.location(in: self)
//
//        let frontTouchedNode = atPoint(location).name
//        if frontTouchedNode == "chick" {
//            print("touched on sprite")
//        }
//    }
}

