//
//  ColliderType.swift
//  RogueFlapper
//
//  Created by Ryan RK on 23/10/2021.
//

import SpriteKit
import GameplayKit

struct ColliderType: OptionSet, Hashable {
    // MARK: Static properties
    
    /// A dictionary to specify which `ColliderType`s should be notified of contacts with other `ColliderType`s.
    static var requestedContactNotifications = [ColliderType: [ColliderType]]()
    
    /// A dictionary of which `ColliderType`s should collide with other `ColliderType`s.
    static var definedCollisions = [ColliderType: [ColliderType]]()

    // MARK: Properties
    
    let rawValue: UInt32

    // MARK: Options
    
    static var Boundary     : ColliderType { return self.init(rawValue: 1 << 0) }
    static var Player       : ColliderType { return self.init(rawValue: 1 << 1) }
    static var Enemy        : ColliderType { return self.init(rawValue: 1 << 2) }
    static var Projectile   : ColliderType { return self.init(rawValue: 1 << 3) }


    // MARK: Hashable
    
    var hashValue: Int {
        return Int(rawValue)
    }
    
    // MARK: CustomDebugStringConvertible
    
    var debugDescription: String {
        switch self.rawValue {
        case ColliderType.Boundary.rawValue:
            return "ColliderType.Boundary"
                
        case ColliderType.Player.rawValue:
            return "ColliderType.Player"
            
        case ColliderType.Enemy.rawValue:
            return "ColliderType.Enemy"
                
        case ColliderType.Projectile.rawValue:
            return "ColliderType.Projectile"
                
        default:
            return "UnknownColliderType(\(self.rawValue))"
        }
    }
    
    // MARK: SpriteKit Physics Convenience
    
    /// A value that can be assigned to a 'SKPhysicsBody`'s `categoryMask` property.
    var categoryMask: UInt32 {
        return rawValue
    }
    
    /// A value that can be assigned to a 'SKPhysicsBody`'s `collisionMask` property.
    var collisionMask: UInt32 {
        // Combine all of the collision requests for this type using a bitwise or.
        let mask = ColliderType.definedCollisions[self]?.reduce(ColliderType()) { initial, colliderType in
            return initial.union(colliderType)
        }
        
        // Provide the rawValue of the resulting mask or 0 (so the object doesn't collide with anything).
        return mask?.rawValue ?? 0
    }
    
    /// A value that can be assigned to a 'SKPhysicsBody`'s `contactMask` property.
    var contactMask: UInt32 {
        // Combine all of the contact requests for this type using a bitwise or.
        let mask = ColliderType.requestedContactNotifications[self]?.reduce(ColliderType()) { initial, colliderType in
            return initial.union(colliderType)
        }
        
        // Provide the rawValue of the resulting mask or 0 (so the object doesn't need contact callbacks).
        return mask?.rawValue ?? 0
    }

    // MARK: ContactNotifiableType Convenience
    
    /**
        Returns `true` if the `ContactNotifiableType` associated with this `ColliderType` should be
        notified of contact with the passed `ColliderType`.
    */
    func notifyOnContactWith(_ colliderType: ColliderType) -> Bool {
        if let requestedContacts = ColliderType.requestedContactNotifications[self] {
            return requestedContacts.contains(colliderType)
        }
        
        return false
    }
    
    
    // MARK: - Functions to add or remove collider type in requestedContactNotifications and definedCollisions
    static func addContactNotificationsList(responder: ColliderType, contacts: [ColliderType]) {
        if ColliderType.requestedContactNotifications[responder] != nil {
            ColliderType.requestedContactNotifications[responder]!.append(contentsOf: contacts)
        } else {
            ColliderType.requestedContactNotifications[responder] = contacts
        }
    }
    
    static func addCollisionList(responder: ColliderType, colliders: [ColliderType]) {
        if ColliderType.definedCollisions[responder] != nil {
            ColliderType.definedCollisions[responder]!.append(contentsOf: colliders)
        } else {
            ColliderType.definedCollisions[responder] = colliders
        }
    }
    
    static func removeContactNotificationsList(responder: ColliderType, contacts: [ColliderType]) {
        for contact in contacts {
            ColliderType.requestedContactNotifications[responder]?.removeAll(where: { colliderType in
                colliderType == contact
            })
        }
    }
    
    static func removeCollisionList(responder: ColliderType, colliders: [ColliderType]) {
        for collider in colliders {
            ColliderType.definedCollisions[responder]?.removeAll(where: { colliderType in
                return colliderType == collider
            })
        }
    }
}
