//
//  CGPoint+IsCloseTo.swift.swift
//  Fitylt
//
//  Created by Lionel Vinh Quang on 07/07/2021.
//

import Foundation

extension CGPoint {
    func isClose(to point: CGPoint, with range: CGFloat) -> Bool {
        let xMax = point.x + range
        let xMin = point.x - range
        let yMax = point.y + range
        let yMin = point.y - range
        
        if (x >= xMin && x <= xMax) && (y >= yMin && y <= yMax) {
            return true
        } else {
            return false
        }
    }
}
