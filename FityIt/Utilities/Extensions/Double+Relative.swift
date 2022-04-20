//
//  CGFloat+Relative.swift
//  Fitylt
//
//  Created by Lionel Vinh Quang on 07/07/2021.
//

import Foundation

extension Double {
    func relative(min: Double, max: Double) -> Double {
        return min + self * (max - min)
    }
}
