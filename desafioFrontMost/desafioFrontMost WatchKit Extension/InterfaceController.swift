//
//  InterfaceController.swift
//  desafioFrontMost WatchKit Extension
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 27/09/17.
//  Copyright © 2017 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications


class InterfaceController: WKInterfaceController {

	
    @IBOutlet var textLabel: WKInterfaceLabel!
    @IBOutlet var timer: WKInterfaceTimer!
    @IBOutlet var button: WKInterfaceButton!
	
	var jokes: [Joke] = []
    var intervalTimer = Timer()
    var didTellJoke = false
    var currentJoke: Joke?
    let notificationManager = UNUserNotificationCenter.current()
    let timeToAnswer: Double = 15.0
    var didCreateNewJokeNotification = false
    let answerTitle = "Acabou seu tempo!"
    let answerBody = "Descubra a resposta hahaha"
    let newJokeTitle = "Nova piada!"
    let newJokeBody = "Uma nova piada quentinha para você hahah"
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.createJokes()
        self.didCreateNewJokeNotification = false

        notificationManager.requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
        }
		
        // Configure interface objects here.
        textLabel.setText("O que é um pontinho vermelho numa árvore?")
        button.setHidden(true)
        showJoke()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        if didTellJoke {
            if #available(watchOSApplicationExtension 4.0, *) {
                WKExtension.shared().isFrontmostTimeoutExtended = true
            } else {/*do nothing*/}
        } else {
            if #available(watchOSApplicationExtension 4.0, *) {
                WKExtension.shared().isFrontmostTimeoutExtended = false
            } else {/*do nothing*/}
        }
        
        WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: Date(timeIntervalSinceNow: 60 * 60 * 4), userInfo: nil) { (error) in
            if error == nil {
                self.showJokeFromBackground()
            }
        }
    }
    
    

    func restartTimer () {
        //Configurando WKInterfaceTimer
        let interval: TimeInterval = timeToAnswer
        timer.stop()
        let time = Date(timeIntervalSinceNow: interval)
        timer.setDate(time)
        timer.start()
        
        createNotification(with: createNotificationContent(title: answerTitle, body: answerBody), trigger: createTrigger())
        
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
    
    func createNotificationContent(title: String, body: String) -> UNMutableNotificationContent {
        let newContent = UNMutableNotificationContent()
        newContent.title = title
        newContent.body = body
        
        return newContent
    }
    
    func createTrigger() -> UNTimeIntervalNotificationTrigger {
        return UNTimeIntervalNotificationTrigger(timeInterval: timeToAnswer, repeats: false)
    }
    
    func showAnswer() {
        button.setHidden(false)
        timer.setHidden(true)
        if WKExtension.shared().applicationState == .background {
            WKInterfaceDevice.current().play(.success)
        } else {/*do nothing*/}
        textLabel.setText(self.currentJoke?.answer)
        didTellJoke = false
    }
    
    func showJoke() {
        setRandomJoke()
        textLabel.setText(currentJoke?.question)
        button.setHidden(true)
        restartTimer()
        didTellJoke = true
    }
    
    func showJokeFromBackground() {
        createNotification(with: createNotificationContent(title: newJokeTitle, body: newJokeBody), trigger: createTrigger())
        didCreateNewJokeNotification = true
    }
    
    func setRandomJoke() {
        let randomIndex = Int(arc4random_uniform(UInt32(jokes.count)))
        self.currentJoke = jokes[randomIndex]
    }
    
    @IBAction func buttonAction() {
        timer.setHidden(false)
        button.setHidden(true)
        showJoke()
        restartTimer()
    }
    
    func createNotification(with content: UNMutableNotificationContent, trigger: UNTimeIntervalNotificationTrigger) {
        guard didCreateNewJokeNotification == false else { return }
        
        let requestIdentifier = UUID().uuidString
        print(content.title)
        
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        notificationManager.add(request) { (error) in
            
        }

    }
}
    
extension InterfaceController {
    
    func createJokes() {
        self.jokes.append(Joke(question: "O que aconteceu com os lápis quando souberam que o dono da Faber Castell morreu?", answer: "Eles ficaram desapontados."))
        self.jokes.append(Joke(question: "A plantinha foi ao hospital mas não foi atendida, porque?", answer: "Porque só tinha médico de plantão."))
        self.jokes.append(Joke(question: "Qual foi a primeira vez que os americanos comeram carne?", answer: "Quando chegou Cristóvão ComLombo."))
        self.jokes.append(Joke(question: "Porque a aranha é o animal mais carente do mundo?", answer: "Porque ela é um aracNeedYou."))
        self.jokes.append(Joke(question: "O que são quatro pontinhos pretos no leite?", answer: "Formigas."))
        self.jokes.append(Joke(question: "Por que é fácil ganhar no 'pedra, papel e tesoura' na cracolândia?", answer: "Porque lá eles sempre escolhem pedra."))
        self.jokes.append(Joke(question: "Para onde vão os homens-bomba depois da morte?", answer: "Para todos os lados."))
        self.jokes.append(Joke(question: "Por que o anãozinho atravessa a rua correndo?", answer: "Para pegar embalo para subir no meio fio."))
        self.jokes.append(Joke(question: "O que é um pontinho vermelho em cima do castelo?", answer: "É uma pimenta do reino."))
        self.jokes.append(Joke(question: "O que é um ponto?", answer: "Um asterisco que passou gel no cabelo."))
        self.jokes.append(Joke(question: "Tenho 40 laranjas, tiro 20. Quantas laranjas eu tenho?", answer: "Eu sabia isso com maçãs."))
        self.jokes.append(Joke(question: "Qual é o contrário de salmão?", answer: "Açúcarpé."))
        self.jokes.append(Joke(question: "Qual é o filme preferido do Batman?", answer: "Os que ele fez."))
        self.jokes.append(Joke(question: "Qual é o estado brasileiro onde as pessoas mais tomam refrigerante de laranja?", answer: "Fanta Catarina."))
        self.jokes.append(Joke(question: "Se meia careca tem 84.592 fios de cabelo, uma careca inteira tem quantos?", answer: "Nenhum."))
        self.jokes.append(Joke(question: "O que acontece quando chove na Inglaterra?", answer: "Vira Inglabarro"))
        self.jokes.append(Joke(question: "Onde os Minions moram?", answer: "Em Condo-Minions."))
        self.jokes.append(Joke(question: "Por que a Dilma não sobe em árvore?", answer: "Porque o José Serra."))
        self.jokes.append(Joke(question: "O que é um pontinho preto no livro?", answer: "Uma formiga querendo entrar pra história."))
        self.jokes.append(Joke(question: "O que acontece se o Thor assoprar?", answer: "Thornado."))
        self.jokes.append(Joke(question: "Por que o Thor vai na academia?", answer: "Para ficar Thorneado."))
    }
}
