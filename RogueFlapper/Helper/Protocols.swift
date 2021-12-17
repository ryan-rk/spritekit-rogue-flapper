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

protocol SpeedControllable {
    var controlledSpeed: CGFloat { get set }
}


// MARK: - Protocols for handling inputs

protocol InputHandler: AnyObject {
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
}

extension InputHandler {
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {}
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {}
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {}
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

protocol Clickable {
    func touchDown()
    func clicked()
    func clickCancelled()
}
