//
//  ViewController.swift
//  Set
//
//  Created by Gurmeet Singh on 12/7/17.
//  Copyright © 2017 Gurmeet Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   var game = SetGame()
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func cardSelected(_ sender: UIButton) {
        if let cardIndex = game.gameCards.index(where: {mapCardToAttributedString(card: $0) == sender.attributedTitle(for: .normal) } ) {
            game.selectCard(atIndex: cardIndex)
  //          print("Selected card index\(cardIndex) card \(game.gameCards[cardIndex])")
        }
        updateGameView()
    }
    
    @IBAction func draw3CardsFromDeck(_ sender: UIButton) {
        if game.gameCards.count < 21 {
          game.draw3Cards()
          updateGameView()
        }
        if game.deck.deck.count < 3 {
           sender.isEnabled = false
        }
    }
    
    func mapCardToAttributedString(card: SetCard) -> NSAttributedString {
        
        var cardDisplayNSAttrDict = [NSAttributedStringKey:Any]()
        
        var color = UIColor.blue
        var symbol = ""
        switch card.symbol {
          case .triangle: symbol = "▲"
          case .square: symbol = "■"
          case .circle: symbol = "●"
        }
        var symbolString = ""
        switch card.number {
          case .one: symbolString = symbol
          case .two: symbolString = symbol + symbol
          case .three: symbolString = symbol + symbol + symbol
        }
        var attrString = NSAttributedString(string: symbolString)
        switch card.color {
          case .red: color = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
          case .green: color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
          case .blue: color = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        }
        var alpha: CGFloat = 1.0
        switch card.shading{
           case .clear: break
           case .striped: cardDisplayNSAttrDict[NSAttributedStringKey.strikethroughStyle] = NSUnderlineStyle.styleDouble.rawValue
           case .solid: alpha = 100.0
                        cardDisplayNSAttrDict[NSAttributedStringKey.strokeWidth] = 5.0
        }
        
        cardDisplayNSAttrDict[NSAttributedStringKey.foregroundColor] = color.withAlphaComponent(alpha)
        
        attrString = NSAttributedString(string: symbolString, attributes: cardDisplayNSAttrDict)
        return attrString
    }
    
    func updateGameView(){
        var cardAttrString = NSAttributedString(string: "")
        for button in cardButtons {
            button.backgroundColor = UIColor.clear
            button.isEnabled = false
            button.layer.borderWidth =  0.0
            button.layer.borderColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            button.setAttributedTitle(NSAttributedString(string: ""), for: .normal)
        }
        var i = 0
        for card in game.gameCards {
            if !card.matched {
              cardAttrString = mapCardToAttributedString(card: card)
              cardButtons[i].setAttributedTitle(cardAttrString, for: .normal)
              cardButtons[i].isHidden = false
              cardButtons[i].isEnabled = true
              cardButtons[i].layer.borderWidth = card.chosen ? 3.0 : 0.0
              cardButtons[i].layer.borderColor = card.chosen ? #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
              cardButtons[i].backgroundColor = UIColor.cyan
            } else {
              cardButtons[i].backgroundColor = UIColor.clear
            }
            i += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.initGame()
        for button in cardButtons {
            button.isHidden = true
        }
        updateGameView()
    }
    
}
