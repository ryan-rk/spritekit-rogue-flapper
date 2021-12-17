//
//  StartMenuScene.swift
//  RogueFlapper
//
//  Created by Ryan RK on 13/12/2021.
//

import SpriteKit
import GameplayKit

class StartMenuScene: GameScene {
    
    let bgManager = BackgroundManager()
    let canvas = Canvas()
    
    override init(size: CGSize) {
        super.init(size: size)
        
        componentSystems = [GKComponentSystem(componentClass: InfiniteScroller.self)]
        
        addEntity(entity: bgManager)
        addEntity(entity: canvas)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        SceneManager.loadLevel(1)
    }
    
}
