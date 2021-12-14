//
//  Animator.swift
//  RogueFlapper
//
//  Created by Ryan RK on 6/12/2021.
//

import SpriteKit
import GameplayKit

class Animator: GameComponent {
    
    var textures = [SKTexture]()

	// MARK: Initializer
    init(texturePrefix: String, texturesCount: Int) {
        super.init()
        
        for i in 1...texturesCount {
            let texture = SKTexture(imageNamed: texturePrefix + String(i))
            textures.append(texture)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func animate(loopCount: Int, restoreOnEnd: Bool, timePerFrame: TimeInterval) {
//        let oldTexture = entity?.component(ofType: SpriteRenderer.self)?.spriteNode.texture
        let animAction = SKAction.animate(with: textures, timePerFrame: timePerFrame, resize: false, restore: restoreOnEnd)
        entity?.component(ofType: SpriteRenderer.self)?.spriteNode.run(animAction)
    }

}
