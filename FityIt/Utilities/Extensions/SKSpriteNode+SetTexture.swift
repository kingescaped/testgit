//
//  SKSpriteNode+SetTexture.swift
//  Fitylt
//
//  Created by Lionel Vinh Quang on 07/07/2021.
//

import SpriteKit

extension SKSpriteNode {
    func setTexture(_ newTexture: SKTexture, byCroppingWith spriteShape: SKSpriteNode, duration: CFTimeInterval) {
        let crop = SKCropNode()
        crop.zPosition = zPosition + 1
        crop.position = position
        
        let fadeInSprite = SKSpriteNode(texture: newTexture, size: size)
        crop.addChild(fadeInSprite)
        
        spriteShape.setScale(0.012)
        spriteShape.position.y = -fadeInSprite.size.height / 2
        spriteShape.position.x = 0
        spriteShape.zPosition = 0
        crop.maskNode = spriteShape
        parent?.addChild(crop)
        
        spriteShape.run(.scale(to: 4, duration: duration))
        crop.run(.sequence([.wait(forDuration: duration),
                            .run { [weak self] in self?.texture = newTexture },
                            .removeFromParent()]))
    }
}
