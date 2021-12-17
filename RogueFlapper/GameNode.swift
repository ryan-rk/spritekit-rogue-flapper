//
//  GameNode.swift
//  RogueFlapper
//
//  Created by Ryan RK on 16/12/2021.
//

import SpriteKit
import GameplayKit

class GameNode: SKNode {
    
    
    // MARK: - Input handling when enable user interaction
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let entityComponents = entity?.components {
            for component in entityComponents {
                if let inputHandler = component as? InputHandler {
                    inputHandler.touchesBegan(touches, with: event)
                }
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let entityComponents = entity?.components {
            for component in entityComponents {
                if let inputHandler = component as? InputHandler {
                    inputHandler.touchesMoved(touches, with: event)
                }
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let entityComponents = entity?.components {
            for component in entityComponents {
                if let inputHandler = component as? InputHandler {
                    inputHandler.touchesEnded(touches, with: event)
                }
            }
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let entityComponents = entity?.components {
            for component in entityComponents {
                if let inputHandler = component as? InputHandler {
                    inputHandler.touchesCancelled(touches, with: event)
                }
            }
        }
    }
    
}
