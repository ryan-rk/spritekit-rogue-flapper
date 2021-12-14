//
//  Protocols.swift
//  RogueFlapper
//
//  Created by Ryan RK on 24/10/2021.
//

import Foundation
import GameplayKit

protocol ContactNotifiableType {

    func contactWithEntityDidBegin(_ entity: GKEntity)
    func contactWithEntityDidEnd(_ entity: GKEntity)
}

protocol GameInputHandler {
    func touchBegan(touches: Set<UITouch>, currentView: SKView)
    func touchMoved(amountFromPrev: CGVector, touches: Set<UITouch>, currentView: SKView)
    func touchEnded(touches: Set<UITouch>, currentView: SKView)
}

extension GameInputHandler {
    func touchBegan(touches: Set<UITouch>, currentView: SKView) {}
    func touchMoved(amountFromPrev: CGVector, touches: Set<UITouch>, currentView: SKView) {}
    func touchEnded(touches: Set<UITouch>, currentView: SKView) {}
}

protocol SpeedControllable {
    var controlledSpeed: CGFloat { get set }
}
