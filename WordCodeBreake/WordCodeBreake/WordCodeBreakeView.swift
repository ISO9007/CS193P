//
//  WordCodeBreakeView.swift
//  WordCodeBreakeView
//
//  Created by nihaoma3000 on 2026/7/20.
//

import SwiftUI

struct WordCodeBreakeView: View {
    
    @Environment(\.words) var words
    @State private var game: WordCodeBreake = WordCodeBreake(pegCount: 5)
    @State private var selection: Int = 0
    
    var body: some View {
        VStack {
            pegCountChooser
            view(for: game.masterCode)
            ScrollView {
                if !game.isOver {
                    view(for: game.guessCode)
                }
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
            PegChooserView(choices: game.pegChoices, onChoose: { peg in
                game.setGuessCode(peg, at: selection)
                selection = (selection + 1) % game.guessCode.pegCount
            }, onGuessClick: {
                guard !game.isOver else { return }
                game.attemptGuess()
                selection = 0
            }, onBackspace: {
                guard !game.isOver else { return }
                game.setGuessCode(Peg.pegMissing, at: selection)
                selection = (selection - 1) < 0 ? 0 : selection - 1
            }, pegChooserMatch: game.pegChooserMatch)
        }
        .padding()
        .onChange(of: words.count, initial: true) {
            if game.attempts.count == 0 {
                if words.count == 0 {
                    game.masterCode.words = "await".uppercased()
                }else {
                    if let newWord = words.random(length: game.pegCount) {
                        game.masterCode.words = newWord
                    }else {
                        game.reset(5)
                        game.masterCode.words = "ERROR"
                    }
                }
            }
        }
    }
    
    var pegCountChooser: some View {
        HStack {
            Text("Peg count:")
            ForEach([3, 4, 5, 6], id: \.self) { count in
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(game.pegCount == count ? .blue : .black)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .background {
                            Button(String(count)) {
                                if let newWord = words.random(length: count) {
                                    game.reset(count)
                                    game.masterCode.words = newWord
                                }else {
                                    game.reset(5)
                                    game.masterCode.words = "ERROR"
                                }
                            }
                            .foregroundStyle(game.pegCount == count ? .blue : .black)
                        }
            }
        }
    }
    
    func view(for code: WordCode) -> some View {
        HStack {
            WordCodeView(code: code, selection: $selection)
            Color.clear.aspectRatio(contentMode: .fit)
                .overlay {
                    if code.kind == .guess {
                        guessButton
                    }else if case .master(_) = code.kind {
                        resetButton
                    }
                }
        }
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
                selection = 0
            }
        }
        .font(.system(size: GuessButton.maximumFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
    var resetButton: some View {
        Button("Reset") {
            withAnimation {
                if let newWord = words.random(length: game.pegCount) {
                    game.reset()
                    game.masterCode.words = newWord
                }else {
                    game.reset(5)
                    game.masterCode.words = "ERROR"
                }
                
                 
            }
        }
        .font(.system(size: GuessButton.maximumFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
    struct GuessButton {
        static let minimumFontSize: CGFloat = 8
        static let maximumFontSize: CGFloat = 80
        static let scaleFactor = minimumFontSize / maximumFontSize
    }
}

#Preview {
    WordCodeBreakeView()
}
