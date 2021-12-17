//
//  Button.swift
//  RogueFlapper
//
//  Created by Ryan RK on 17/12/2021.
//

import SpriteKit
import GameplayKit

class Button: GameEntity, Clickable {
    
    // MARK: - Properties
    

	// MARK: - Initializer
    init(name: String = "Button") {
        super.init(name: name, renderLayer: .world)
        
        let buttonText = TextRenderer(text: "Button Text", fontSize: 20)
        addComponent(buttonText)
        buttonText.textNode.zPosition = 1
        let buttonBg = SpriteRenderer(spriteNode: SKSpriteNode(color: .systemPink, size: CGSize(width: 256, height: 64)))
        addComponent(buttonBg)
        let clickListener = ClickListener()
        addComponent(clickListener)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    // MARK: - Protocol conformance
    func touchDown() {
        node.run(SKAction.moveBy(x: 0, y: -10, duration: 0.1))
    }
    
    func clicked() {
        print("button clicked")
        node.run(SKAction.moveBy(x: 0, y: 10, duration: 0.1))
    }
    
    func clickCancelled() {
        node.run(SKAction.moveBy(x: 0, y: 10, duration: 0.1))
    }
}
