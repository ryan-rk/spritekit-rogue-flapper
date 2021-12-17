//
//  InputNode.swift
//  RogueFlapper
//
//  Created by Ryan RK on 17/12/2021.
//

import SpriteKit

class InputNode: GameNode {
    
    weak var inputHandler: InputHandler?
    
    init(touchRegion: [SKNode]) {
        super.init()
        
        self.isUserInteractionEnabled = true
        addChildren(touchRegion)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
