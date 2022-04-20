//
//  ShapeFactory.swift
//  Fitylt
//
//  Created by Lionel Vinh Quang on 07/07/2021.
//

import SpriteKit

enum ShapeType {
    case circle
    case square
    case triangle
    case pentagon
    
    static let allCases: [ShapeType] = [.circle, .square, .triangle, .pentagon]
    
    static var lastRandomShapeIndex: Int = 0
    static func randomShape() -> Shape {
        var i = 0
        repeat {
            i = Int.random(allCases.count)
        } while i == lastRandomShapeIndex
        
        lastRandomShapeIndex = i
        return Shape(type: allCases[i])
    }
}

