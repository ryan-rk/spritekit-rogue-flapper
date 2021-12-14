//
//  GameViewController.swift
//  RogueFlapper
//
//  Created by Ryan RK on 23/10/2021.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(UIProp.displaySize)
        
//        let sceneNode = GameScene(size: UIProp.displaySize)
//        let sceneNode = TestScene(size: UIProp.displaySize)
//        let sceneNode = StartMenuScene(size: UIProp.displaySize)
        // Set the scale mode to scale to fit the window
//        sceneNode.scaleMode = .aspectFit
        
        // Present the scene
        if let view = self.view as! SKView? {
            SceneManager.view = view
            SceneManager.sceneSize = UIProp.displaySize
            SceneManager.loadStartMenu()
            
//            view.presentScene(sceneNode)
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
}
