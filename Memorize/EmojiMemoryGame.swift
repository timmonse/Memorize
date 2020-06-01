//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Evan Timmons on 5/25/20.
//  Copyright © 2020 Evan Timmons. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        var emojis = ["👻", "🎃", "🕷", "🕸", "🍬", "😀", "🐶", "🍏", "⚽️", "🚗", "⌚️", "❤️"]
        emojis.shuffle(); // A1 Extra Credit
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) { pairIndex in
             return emojis[pairIndex]
        }
    }
        
    // MARK: - Access to the model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card : MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
}

struct EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
