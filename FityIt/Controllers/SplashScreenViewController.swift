//
//  SplashScreenViewController.swift
//  Fitylt
//
//  Created by Lionel Vinh Quang on 07/07/2021.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GCHelper.sharedInstance.authenticateLocalUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppCache.instance.resetSounds(initializeAfter: true)
        AppCache.instance.initializeInitialScreenBackgroundTexture(screenSize: InitialScene.calculateSceneSize(self.view.frame.size))
        
        delay(0.3) {
            let vc = AppDelegate.gameViewController
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
