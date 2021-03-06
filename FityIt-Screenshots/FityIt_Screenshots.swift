//
//  FityIt_Screenshots.swift
//  FityIt-Screenshots
//
//  Created by Lionel Vinh Quang on 07/07/2021.
//

import XCTest

class FityIt_Screenshots: XCTestCase {
        override func setUp() {
        super.setUp()
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    func testExample() {
        let app = XCUIApplication()
        let element1 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
        
        sleep(2)
        snapshot("1-GameScreen")
        element1.tap()
        sleep(1)
        
        element1.tap()
        sleep(2)
        snapshot("2-GameScreen")
        
        element1.tap()
        sleep(1)
        snapshot("3-GameScreen")
        
        element1.tap()
        sleep(2)
        snapshot("4-GameScreen")
        
        element1.tap()
        sleep(1)
        snapshot("5-GameScreen")
        
    }
}
