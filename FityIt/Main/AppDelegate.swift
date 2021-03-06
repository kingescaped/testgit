//
//  AppDelegate.swift
//  Fitylt
//
//  Created by Lionel Vinh Quang on 07/07/2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var instance: AppDelegate { return UIApplication.shared.delegate as! AppDelegate }
    static var gameViewController: GameViewController { return instance.gameViewController }
    
    var window: UIWindow?
    private lazy var gameViewController = GameViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if DEBUG && !SNAPSHOT
            BUILD_MODE = .debug
        #else
            BUILD_MODE = .release
        #endif
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = UIColor.white
        window!.makeKeyAndVisible()
        window!.rootViewController = SplashScreenViewController()
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        AppPersistence.matchesPlayedSinceLaunch = 0
        if let gameScene = gameViewController.gameView.scene as? GameScene {
            gameScene.updateTimer.lap()
        }
    }
}

