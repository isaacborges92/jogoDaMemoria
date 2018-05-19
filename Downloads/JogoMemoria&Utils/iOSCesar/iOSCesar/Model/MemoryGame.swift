//
//  MemoryGame.swift
//  iOSCesar
//
//  Created by Marlon Chalegre on 14/04/18.
//  Copyright © 2018 CESAR School. All rights reserved.
//

import Foundation

class MemoryGame {
    
    var cards = [Card]()
    
    //Número de Jogadas
    
    static var numJogadas = 0
    static func upNumJogada(){
        numJogadas += 1
    }
    
    //Points
    
    static var points = 0
    
    static func getPoints() -> Int{
        return points
    }
    
    static func setPoints(num: Int){
        points += num
    }
    
    func randomCards(){
        var array = [Card]()
        
        while !cards.isEmpty{
            var randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            array.append(cards[randomIndex])
            cards.remove(at: randomIndex)
        }
        
        cards = array
    }
    
    init(numberOfPairs: Int) {
        for _ in 0..<numberOfPairs {
            let card = Card()
            cards += [card, card]
        }
        randomCards()
        MemoryGame.points = 0
        MemoryGame.numJogadas = 0
    }
    
    func isEndGame() -> Bool{
        var fimDeJogo = false
        
        for index in cards.indices {
            if !cards[index].isMatched {
                fimDeJogo = false
                break
            }else{
                fimDeJogo = true
            }
        }
        return fimDeJogo
    }
    
    func chooseCard(at index: Int) {
        let cardsUp = cards.indices.filter({ cards[$0].isUp })
        let currentUpCardIndex = cardsUp.count == 1 ? cardsUp.first : nil
        
        if !cards[index].isMatched {
            if let matchIndex = currentUpCardIndex {
                if matchIndex != index && cards[matchIndex].indentifier == cards[index].indentifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    MemoryGame.setPoints(num: 2)
                    MemoryGame.upNumJogada()
                } else{
                    MemoryGame.setPoints(num: -1)
                    MemoryGame.upNumJogada()
                }
                cards[index].isUp = true
            } else {
                for i in cards.indices {
                    cards[i].isUp = (i == index)
                }
            }
        }
    }
}
