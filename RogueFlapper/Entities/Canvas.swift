//
//  Canvas.swift
//  RogueFlapper
//
//  Created by Ryan RK on 13/12/2021.
//

import SpriteKit
import GameplayKit

class Canvas: GameEntity {
    
    let textComponent = TextRenderer(text: "START", fontSize: 64)

	// MARK: Initializer
    init(name: String = "Canvas") {
        super.init(name: name, renderLayer: .ui)
        addComponent(textComponent)
        textComponent.textNode.position = UIProp.displayCenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
