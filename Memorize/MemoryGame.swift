//
//  MemoryGame.swift
//  Memorize
//
//  Created by Evan Timmons on 5/25/20.
//  Copyright © 2020 Evan Timmons. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card : Card) {
        print("card chosen: \(card)")
    }
    
    init (numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp : Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
