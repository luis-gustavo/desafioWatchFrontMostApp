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

	var jokes: [Joke]!
	
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.createJokes()
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
