//
//  SceneManager.swift
//  RogueFlapper
//
//  Created by Ryan RK on 13/12/2021.
//

import SpriteKit

class SceneManager {
    
    static var view = SKView()
    static var sceneSize = CGSize.zero
    static var sceneScaleMode: SKSceneScaleMode = .aspectFill
    
    static func loadStartMenu() {
        let scene = StartMenuScene(size: sceneSize)
        view.presentScene(scene)
    }
    
    static func loadLevel(_ level: Int) {
        let scene = LevelScene(level: level, size: sceneSize)
        view.presentScene(scene)
    }
    
}
