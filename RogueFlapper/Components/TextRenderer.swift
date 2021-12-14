//
//  TextRenderer.swift
//  RogueFlapper
//
//  Created by Ryan RK on 13/12/2021.
//

import SpriteKit
import GameplayKit

class TextRenderer: GameComponent {
    
    let textNode: SKLabelNode
    let textString: String

	// MARK: Initializer
    init(text: String, fontName: String = GameConf.Font.baseFontName, fontSize: CGFloat, fontColor: UIColor = GameConf.Font.baseFontColor) {
        textString = text
        textNode = SKLabelNode(text: text)
        super.init()
        
        textNode.fontName = fontName
        textNode.fontSize = fontSize
        textNode.fontColor = fontColor
        
    }
    
    override func didAddToEntity() {
        entityNode?.addChild(textNode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
