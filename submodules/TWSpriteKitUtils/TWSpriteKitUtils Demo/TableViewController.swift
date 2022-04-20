//
//  TableViewController.swift
//  TWSpriteKitUtils
//  Fitylt
//
//  Created by Lionel Vinh Quang on 07/07/2021.
//

import UIKit
import SpriteKit

class TableViewController: UITableViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nvc = segue.destination as? UINavigationController
        let skView = nvc?.viewControllers.first?.view as? SKView
        
        let transition = SKTransition.crossFade(withDuration: 2)
        
        switch segue.identifier! {
        case "ButtonsSegue":
            skView?.presentScene(ButtonsDemoScene(size:skView!.frame.size), transition: transition)
        case "SwitchesSegue":
            skView?.presentScene(SwitchesDemoScene(size:skView!.frame.size), transition: transition)
        case "CollectionNodeSegue":
            skView?.presentScene(CollectionNodeDemoScene(size:skView!.frame.size), transition: transition)
        case "StackNodeSegue":
            skView?.presentScene(StackNodeDemoScene(size:skView!.frame.size), transition: transition)
        default:
            break
        }
    }
    
}
