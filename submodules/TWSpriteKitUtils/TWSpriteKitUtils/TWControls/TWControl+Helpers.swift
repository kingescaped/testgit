//
//  TWControl+Helpers.swift
//  Fitylt
//
//  Created by Lionel Vinh Quang on 07/07/2021.
//

import SpriteKit

internal extension TWControl {
    
    internal func playSound(instanceSoundFileName fileName: String?, defaultSoundFileName: String?) {
        
        let soundEnabled = TWControl.defaultSoundEffectsEnabled ?? soundEffectsEnabled
        
        if soundEnabled {
            if let soundFileName = fileName {
                let action = SKAction.playSoundFileNamed(soundFileName, waitForCompletion: true)
                self.run(action)
                self.run(action)
            }
            else if let soundFileName = defaultSoundFileName {
                let action = SKAction.playSoundFileNamed(soundFileName, waitForCompletion: true)
                self.run(action)
                self.run(action)
            }
        }
    }
}
