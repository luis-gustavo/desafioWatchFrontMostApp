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

    @IBOutlet var textLabel: WKInterfaceLabel!
    @IBOutlet var timer: WKInterfaceTimer!
    @IBOutlet var button: WKInterfaceButton!
    
    var intervalTimer = Timer()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        textLabel.setText("O que é um pontinho vermelho numa árvore?")
        button.setHidden(true)
        restartTimer()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func restartTimer () {
        //Configurando WKInterfaceTimer
        let interval: TimeInterval = 60.0
        timer.stop()
        let time = Date(timeIntervalSinceNow: interval)
        timer.setDate(time)
        timer.start()
        
        //Configurando Timer
        if intervalTimer.isValid {
            intervalTimer.invalidate()
        }
        self.intervalTimer = Timer.scheduledTimer(timeInterval: interval,
                                                  target: self,
                                                  selector: #selector(self.showAnswer),
                                                  userInfo: nil,
                                                  repeats: false)
    }
    
    func  showAnswer() {
        button.setHidden(false)
        timer.setHidden(true)
        textLabel.setText("Um MORANGOTANGO")
    }
    
    @IBAction func buttonAction() {
        timer.setHidden(false)
        button.setHidden(true)
        textLabel.setText("O que é um pontinho vermelho numa árvore?")
        restartTimer()
    }
    
}
