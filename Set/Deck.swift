//
//  Deck.swift
//  Set
//
//  Created by Gurmeet Singh on 12/7/17.
//  Copyright © 2017 Gurmeet Singh. All rights reserved.
//

import Foundation

struct Deck {
    
var deck: [SetCard] = []

  mutating func initDeck() {
    var cards: [SetCard] = []
    for number in SetCard.Number.all {
        for symbol in SetCard.Symbol.all {
            for shading in SetCard.Shading.all {
                for color in SetCard.Color.all {
                    let newCard: SetCard = SetCard(number: number, symbol: symbol,
                                                   shading: shading, color: color,
                                                   chosen: false, matched: false)
                    cards.append(newCard)
                }
            }
        }
    }
    deck = cards
  }
    
 mutating func shuffleDeck() {
            for index in 0..<deck.count {
                let swapIndex = Int(arc4random_uniform(UInt32(deck.count)))
                deck.swapAt(index, swapIndex)
            }
  }
    
    func printDeck(){
        for index in 0..<deck.count {
            print("Element at index \(index) is \(deck[index])")
        }
    }
    
    mutating func drawCards(drawNCards n: Int) -> [SetCard] {
        var cards: [SetCard] = []
        for _ in 0..<n {
            if let aCard = deck.popLast() {
               cards.append(aCard)
            }
        }
        return cards
    }
    
  init() {
    initDeck()
    shuffleDeck()
  }
}
