//
//  SKTexture+Extensions.swift
//  Fitylt
//
//  Created by Lionel Vinh Quang on 07/07/2021.
//

import SpriteKit

extension SKTexture {
    convenience init(radialGradient size: CGSize, colors: [SKColor]) {
        self.init(image: UIImage.radialGradient(size: size, colors: colors))
    }
    convenience init(linearGradient size: CGSize, colors: [SKColor]) {
        self.init(image: UIImage.linearGradient(size: size, colors: colors))
    }
    convenience init(circleOfRadius radius: CGFloat, color: SKColor) {
        self.init(image: UIImage.circle(withRadius: radius, color: color))
    }
    convenience init(squareOfLenght lenght: CGFloat, color: UIColor) {
        self.init(image: UIImage.square(withLenght: lenght, color: color))
    }
    convenience init(pentagonWithWidth width: CGFloat, color: UIColor) {
        self.init(image: UIImage.pentagon(withWidth: width, color: color))
    }
    convenience init(triangleWithSize size: CGSize, color: UIColor) {
        self.init(image: UIImage.triangle(withSize: size, color: color))
    }
}
