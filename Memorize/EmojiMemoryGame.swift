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
    
    private static var themes = [Theme("Halloween", with: ["👻", "🎃", "🕷", "🕸", "🍬"], count: 5, color: Color.orange),
                  Theme("Christmas", with: ["🎄", "🎅", "🤶", "🎁", "🍪"], color: Color.green),
                  Theme("Animals", with: ["🦙", "🐘", "🦜", "🐅", "🐕"], count: 3, color: Color.red),
                  Theme("Sports", with: ["🏀", "🏈", "🎾", "⚾️", "⚽️"], color: Color.blue),
                  Theme("Faces", with: ["😀", "😍", "🤪", "🥺", "🙄"], color: Color.purple)]
    
    static var gameTheme = themes[0]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        gameTheme = themes.randomElement()!
        var emojis = gameTheme.emojis
        emojis.shuffle()
        return MemoryGame<String>(numberOfPairsOfCards: gameTheme.numberOfCardsToShow) { pairIndex in
             emojis[pairIndex]
        }
    }
        
    // MARK: - Access to the model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var theme: Theme {
        EmojiMemoryGame.gameTheme
    }
    
    // MARK: - Intent(s)
    
    func choose(card : MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    //MARK: - Game Theme
    
    static func chooseTheme() -> Theme {
        return self.themes.randomElement()!
    }
    
    struct Theme {
        let themeName: String
        let emojis: [String]
        let numberOfCardsToShow: Int
        let themeColor: Color
        
        init(_ themeName: String, with emojis: [String], color themeColor: Color){
            self.themeName = themeName
            self.emojis = emojis
            self.numberOfCardsToShow = Int.random(in: 2...5)
            self.themeColor = themeColor
        }
        
        init(_ themeName: String, with emojis: [String], count numberOfCardsToShow: Int, color themeColor: Color){
            self.themeName = themeName
            self.emojis = emojis
            self.numberOfCardsToShow = numberOfCardsToShow
            self.themeColor = themeColor
        }
    }
}

struct EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
