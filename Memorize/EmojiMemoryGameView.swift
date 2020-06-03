//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Evan Timmons on 5/22/20.
//  Copyright © 2020 Evan Timmons. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel = EmojiMemoryGame()
    
    var body: some View {
        VStack {
            Text("Score: \(viewModel.score)")
                .bold()
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(EmojiMemoryGame.gameTheme.themeColor)
            Text("\(EmojiMemoryGame.gameTheme.themeName) Theme")
            Button("New Game") {
                self.viewModel.newGame()
            }
        }
        .padding()
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geomerty in
            self.body(for: geomerty.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack(){
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(AngularGradient(gradient: Gradient(colors: [EmojiMemoryGame.gameTheme.themeColor, Color.black]), center: UnitPoint()))
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    //MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView()
    }
}
