//
//  SetGame.swift
//  Set
//
//  Created by Gurmeet Singh on 12/7/17.
//  Copyright © 2017 Gurmeet Singh. All rights reserved.
//

import Foundation

struct SetGame {
    
    var deck = Deck()
    var gameCards: [SetCard] = []
    
    mutating func initGame(){
        gameCards = deck.drawCards(drawNCards: 12)
/*
        selectCard(atIndex: 2)
        printCards()
 */
        
    }
    
    mutating func draw3Cards() {
        if deck.deck.count > 3 {
           gameCards += deck.drawCards(drawNCards: 3)
        }
    }
    
    mutating func processMatches() {
        var chosenCards = [SetCard]()
        var setOfNums = Set<SetCard.Number>()
        var setOfColor = Set<SetCard.Color>()
        var setOfShading = Set<SetCard.Shading>()
        var setOfSymbol = Set<SetCard.Symbol>()
        
        if numberOfChosenCards() == 3 {
            chosenCards = gameCards.filter{$0.chosen}
            setOfNums = Set(chosenCards.map {$0.number})
            setOfColor = Set(chosenCards.map {$0.color})
            setOfShading = Set(chosenCards.map {$0.shading})
            setOfSymbol = Set(chosenCards.map {$0.symbol})
            if !((setOfNums.count == 2) ||
                (setOfColor.count == 2) ||
                (setOfShading.count == 2) ||
                (setOfSymbol.count == 2) ){
                  print("It's a set")
                for i in 0..<gameCards.count {
                    if gameCards[i].chosen {
                        gameCards[i].matched = true
                        gameCards[i].chosen = false
                    }
                }
                gameCards = gameCards.filter({!$0.matched})
                draw3Cards()
            }
        }
        
    }
    
    func numberOfChosenCards() -> Int {
       return gameCards.filter{$0.chosen}.count
    }
    
    func printCards(){
        print("Total chosen cards = \(numberOfChosenCards())")
        for index in 0..<gameCards.count {
            print("Element at index \(index) is \(gameCards[index])")
        }
        print("---")
    }
    
    mutating func selectCard(atIndex index:Int){
        if index >= 0, index < gameCards.count {
            if !gameCards[index].matched {
                if gameCards[index].chosen {
                    gameCards[index].chosen = false
                } else if (numberOfChosenCards() < 3) {
                    gameCards[index].chosen = true
                } else if (numberOfChosenCards() == 3) {
                    for i in gameCards.indices {
                        gameCards[i].chosen = false
                        gameCards[index].chosen = true
                    }
                }
            }
        }
        processMatches()
    }
}
