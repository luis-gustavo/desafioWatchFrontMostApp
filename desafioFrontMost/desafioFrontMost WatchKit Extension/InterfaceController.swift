//
//  InterfaceController.swift
//  desafioFrontMost WatchKit Extension
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 27/09/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    var didTellJoke = false

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        if didTellJoke {
            // mostrar resposta
        } else {
            // mostrar nova piada
        }
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        
        if didTellJoke {
            // start timer
            // play haptic when time is over
            if #available(watchOSApplicationExtension 4.0, *) {
                WKExtension.shared().isFrontmostTimeoutExtended = true
            } else {/*do nothing*/}
        } else {
            if #available(watchOSApplicationExtension 4.0, *) {
                WKExtension.shared().isFrontmostTimeoutExtended = false
            } else {/*do nothing*/}
        }
    }
    
}
