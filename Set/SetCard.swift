//
//  SetCard.swift
//  Set
//
//  Created by Gurmeet Singh on 12/7/17.
//  Copyright © 2017 Gurmeet Singh. All rights reserved.
//

import Foundation

struct SetCard {
    enum Number {
        case one
        case two
        case three
        static var all: [Number] {return [.one,.two,.three] }
    }
    enum Symbol {
        case triangle
        case circle
        case square
        static var all: [Symbol] { return [.triangle,.circle,.square]}
    }
    enum Shading {
        case clear
        case striped
        case solid
        static var all: [Shading] { return [.clear,.striped,.solid]}
    }
    enum Color {
        case red
        case green
        case blue
        static var all: [Color] { return [.red,.green,.blue]}
    }
    
    var number: Number = .one
    var symbol: Symbol = .triangle
    var shading: Shading = .clear
    var color: Color = .red
    
    var chosen = false
    var matched = false
    
}
