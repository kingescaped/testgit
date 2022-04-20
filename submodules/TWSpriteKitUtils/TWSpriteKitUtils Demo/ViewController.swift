//
//  ViewController.swift
//  TWSpriteKitUtils Demo
//  Fitylt
//
//  Created by Lionel Vinh Quang on 07/07/2021.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true

        if (view as? SKView)?.scene != nil {
            view.subviews.first?.removeFromSuperview()
        }
    }
}
