//
//  AppDefines.swift
//  Fitylt
//
//  Created by Lionel Vinh Quang on 07/07/2021.
//

import Foundation
import SpriteKit

enum AppDefines {
    enum Constants {
        static let mainLeaderboardID = "FityItLeaderboard"
        static let appStoreID = "id991444581"
        static let appStoreLink = "https://itunes.apple.com/us/app/id991444581"
        static let isiPad = UIDevice.current.userInterfaceIdiom == .pad
        static let isiPhoneX: Bool = UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436
    }
    
    enum FontName {
        static let defaultLight = "VAGRoundedStd-Light"
        static let defaultBlack = "VAGRoundedStd-Black"
        static let defaultBold = "VAGRoundedStd-Bold"
    }
    
    enum Timings {
        static let fadeIn: TimeInterval = 0.6
        static let fadeOut: TimeInterval = 0.4
        static let slide: TimeInterval = 0.6
        static let transitionDelay: TimeInterval = 0.4
    }
    
    enum Transition {
        static let toGame = SKTransition.doorsOpenVertical(withDuration: Timings.transitionDelay)
        static let toInitial = SKTransition.doorsCloseVertical(withDuration: Timings.transitionDelay)
    }
}
