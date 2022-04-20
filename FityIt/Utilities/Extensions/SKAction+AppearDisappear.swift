//
//  SKAction+AppearDisappear.swift
//  Fitylt
//
//  Created by Lionel Vinh Quang on 07/07/2021.
//

import SpriteKit

extension SKAction {
    class func disappearAnimated(_ node: SKNode, time: CGFloat) -> SKAction {
        let scaleEffect = SKTScaleEffect(node: node, duration: TimeInterval(time), startScale: CGPoint(x: node.xScale, y: node.yScale), endScale: CGPoint(x: 0.0001, y: 0.0001))
        scaleEffect.timingFunction = SKTTimingFunctionExponentialEaseIn
        
        let fade: SKAction = .fadeOut(withDuration: TimeInterval(0.9 * time))
        
        return .group([.actionWithEffect(scaleEffect), fade])
    }
    
    class func appearAnimated(_ node: SKNode, time: CGFloat, scale: CGFloat = 1) -> SKAction {
        let scaleEffect = SKTScaleEffect(node: node, duration: TimeInterval(time), startScale: CGPoint(x: 0.0001, y: 0.0001), endScale: CGPoint(x: scale, y: scale))
        scaleEffect.timingFunction = SKTTimingFunctionBounceEaseOut
        
        let fade: SKAction = .fadeIn(withDuration: TimeInterval(0.9 * time))
        
        return .group([.actionWithEffect(scaleEffect), fade])
    }
}
