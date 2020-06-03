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
            Button("New Game") {
                self.viewModel.newGame()
            }
            .frame(width: 350, height: 10, alignment: Alignment.trailing)
            Text("\(EmojiMemoryGame.gameTheme.themeName)")
                .font(Font.largeTitle)
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                .padding(5)
            }
                .padding()
                .foregroundColor(EmojiMemoryGame.gameTheme.themeColor)
            Text("Score: \(viewModel.score)")
                .bold()
                .font(Font.largeTitle)
                .foregroundColor(EmojiMemoryGame.gameTheme.themeColor)
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
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack(){
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockWise: true)
                    .padding(5).opacity(0.40)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    //MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
