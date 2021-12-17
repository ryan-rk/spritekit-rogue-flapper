//
//  ClickListener.swift
//  RogueFlapper
//
//  Created by Ryan RK on 16/12/2021.
//

import SpriteKit
import GameplayKit

class ClickListener: GameComponent, InputHandler {
    
    // MARK: - Properties
    var clicked = { ()->Void in }
    

	// MARK: - Initializer
    override init() {
        super.init()
    }
    
    // Component must be added as the last component of an entity
    override func didAddToEntity() {
        if let entityNode = entityNode {
            entityNode.isUserInteractionEnabled = true
            entityNode.enumerateChildNodes(withName: "//*") { node, _ in
                node.tags[.clickableTag] = "true"
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let clickable = entity as? Clickable {
            clickable.touchDown()
        }
    }
    
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if let clickable = entity as? Clickable {
            if let entityNode = entityNode {
                let location = touch.location(in: entityNode)
                let touchedNode = entityNode.atPoint(location)
                print(touchedNode.name)
                print(touchedNode.tags[.clickableTag])
                if touchedNode.tags[.clickableTag] == "true" {
                    clickable.clicked()
                } else {
                    clickable.clickCancelled()
                }
            }
        }
    }
    
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let clickable = entity as? Clickable {
            clickable.clickCancelled()
        }
    }

}
