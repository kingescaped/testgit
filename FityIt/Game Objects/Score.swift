//
//  Score.swift
//  Fitylt
//
//  Created by Lionel Vinh Quang on 07/07/2021.
//

import Foundation

struct Score {
    var points = 0
    
    init(points: Int) {
        self.points = points
    }
    
    func highScorePoints() -> Int {
        return AppPersistence.highScorePoints
    }
}
