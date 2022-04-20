//
//  SKAction+GlitchColors.swift
//  Fitylt
//
//  Created by Lionel Vinh Quang on 07/07/2021.
//

import SpriteKit

extension SKAction {
    static func textureGlitch(_ originalTextureShape: ShapeType, duration: TimeInterval, availableTextureShape: [ShapeType]) -> SKAction {
        let remainingTextures = availableTextureShape.filter { $0 != originalTextureShape }
        var interElapsedTime: CGFloat = 0
        return .customAction(withDuration: duration) {(node, elapsedTime) in
            if elapsedTime < CGFloat(duration) {
                if elapsedTime >= interElapsedTime {
                    interElapsedTime += CGFloat(duration)/3.4
                    (node as! SKSpriteNode).texture = AppCache.instance.gradient(shape: remainingTextures[Int.random(within: 0..<remainingTextures.count)])
                }
            } else {
                (node as! SKSpriteNode).texture = nil
                (node as! SKSpriteNode).color = .darkerBlack
            }
        }
    }
}

