//
//  WorldSpeedController.swift
//  RogueFlapper
//
//  Created by Ryan RK on 14/12/2021.
//

import SpriteKit
import GameplayKit

class WorldSpeedController: GameComponent {
    
    // MARK: - Properties
    
    var player: Player?
    var speedControlledList = [SpeedControllable]()

	// MARK: - Initializer
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    
    func attachController() {
//        print("attaching controller")
        if let levelScene = entityGameScene as? LevelScene {
            player = levelScene.player
//            print("player success")
        }
        if let entityComponents = entity?.components {
            for component in entityComponents {
                if let speedControllable = component as? SpeedControllable {
                    speedControlledList.append(speedControllable)
                }
            }
        }
//        print(speedControlledList.count)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if let player = player {
            for index in 0 ..< speedControlledList.count {
                speedControlledList[index].controlledSpeed = player.speed
            }
        }
    }

}
