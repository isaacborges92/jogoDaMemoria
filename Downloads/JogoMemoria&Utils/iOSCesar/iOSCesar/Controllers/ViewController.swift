//
//  ViewController.swift
//  iOSCesar
//
//  Created by Marlon Chalegre on 13/04/18.
//  Copyright © 2018 CESAR School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblPontuacao: UILabel!
    @IBOutlet weak var lblJogadas: UILabel!
    
    var game: MemoryGame!
    var emoticonDict = [Int:String]()
    
    var emoticons = ["👻", "🎃", "💀", "😈", "😱", "🦇", "🕷", "🤡", "🕸", "🦉"]
    var countJogadas: Int = 0
    
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        self.game = MemoryGame(numberOfPairs: (cardButtons.count/2))
    }
    
    func updateGameScreen() {
        var cards = game.cards
        
        for index in cardButtons.indices {
            if cards[index].isUp {
                cardButtons[index].setTitle(selectEmoticon(for: cards[index].indentifier), for: .normal)
                cardButtons[index].backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                cardButtons[index].isEnabled = false
            } else {
                cardButtons[index].setTitle("", for: .normal)
                cardButtons[index].backgroundColor = cards[index].isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                cardButtons[index].isEnabled = cards[index].isMatched ? false : true
            }
        }
        
        lblPontuacao.text = "Pontuação: \(MemoryGame.getPoints())"
        lblJogadas.text   = "Jogadas: \(MemoryGame.numJogadas)"
        
        if game.isEndGame() { //Verifica o jogo encerrou
            let alert = UIAlertController(title: "Parabéns, voce terminou o jogo!", message: "Deseja jogar novamente?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Não", style: .destructive, handler: {action in self.navigationController?.popViewController(animated: true)}))
            
            alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: {action in self.game = MemoryGame(numberOfPairs: (self.cardButtons.count/2))
                self.emoticons = ["👻", "🎃", "💀", "😈", "😱", "🦇", "🕷", "🤡", "🕸", "🦉"]
                self.updateGameScreen()
            }))
            
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func selectCard(_ sender: UIButton) {
        var position = 0
        for i in cardButtons.indices {
            if sender == cardButtons[i] {
                position = i
                break
            }
        }
        game.chooseCard(at: position)
        updateGameScreen()
    }
    
    func selectEmoticon(for id: Int) -> String {
        if emoticonDict[id] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emoticons.count)))
            emoticonDict[id] = emoticons.remove(at: randomIndex)
        }
        return emoticonDict[id]!
    }
}

