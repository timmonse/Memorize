//
//  MemoryGame.swift
//  Memorize
//
//  Created by Evan Timmons on 5/25/20.
//  Copyright © 2020 Evan Timmons. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var score: Int = 0
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                if index == newValue {
                    cards[index].isFaceUp = true
                }
                else {
                    if cards[index].isFaceUp {
                        cards[index].hasBeenSeen = true
                    }
                    cards[index].isFaceUp = false
                }
            }
        }
    }
    
    mutating func choose(card : Card) {
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            let firstTime = Date.init()
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    let secondTime = Date.init()
                    let timeDifference = secondTime.timeIntervalSince(firstTime) * 10e4
                    print(timeDifference)
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += Int(max(10 - timeDifference, 2))
                }
                else{
                    if cards[chosenIndex].hasBeenSeen {
                        score -= 1
                    }
                    if cards[potentialMatchIndex].hasBeenSeen {
                        score -= 1
                    }
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
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
        var isFaceUp : Bool = false
        var isMatched: Bool = false
        var hasBeenSeen: Bool = false
        var content: CardContent
        var id: Int
    }
}
