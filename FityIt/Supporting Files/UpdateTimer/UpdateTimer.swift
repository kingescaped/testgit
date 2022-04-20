//
//  UpdateTimer.swift
//  GameObjects
//
//  Created by Lionel Vinh Quang on 07/07/2021.
//

import Foundation

public struct UpdateTimer
{
    public init() {}
    
    public private(set) var timeSinceLastUpdate = TimeInterval(0)
    
    public private(set) var timeSinceFirstUpdate = TimeInterval(0)
    
    public private(set) var timeSinceLastLap = TimeInterval(0)
    
    public private(set) var previousUpdateTime = TimeInterval(0)
    
    public private(set) var frameCount : Int = 0
    
    private var firstUpdate = true
    
    public mutating func update(currentTime:TimeInterval)
    {
        if firstUpdate {
            previousUpdateTime = currentTime
            firstUpdate = false
        }
        
        timeSinceLastUpdate = currentTime - previousUpdateTime
        timeSinceFirstUpdate += timeSinceLastUpdate
        previousUpdateTime = currentTime
        
        timeSinceLastLap += timeSinceLastUpdate
        
        frameCount += 1
    }
    
    public mutating func lap() {
        timeSinceLastLap = 0
    }
}
