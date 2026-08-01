//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/9.
//

import SwiftUI

struct CodeBreakerView: View {
    // MARK: Data Owned by me
    @State private var game = CodeBreaker()
    @State private var selection: Int = 0
    
    // MARK: - body
    var body: some View {
        VStack {
            view(for: game.masterCode)
            ScrollView {
                if !game.isOver {
                    view(for: game.guess)
                }
                
                ForEach(game.attempts.reversed(), id: \Code.pegs) { code in
                    view(for: code)
                }
                
            }
            PegChooser(choise: game.pegsChoise, gameKind: game.gameKind) { peg in
                game.setGuessPeg(peg: peg, at: selection)
                selection = (selection + 1) % game.guess.pegs.count
            }
        }
        .padding()
        .onAppear {
            game.resetGame()
        }
    }
    
    var guessbutton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
                selection = 0
            }
        }
        .font(.system(size: GuessButton.maximumFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor) // 按比例缩小, 比如这里80字体,缩小0.1就是8
    }
    
    var resetGameButton: some View {
        Button("Reset Game") {
            withAnimation {
                game.resetGame()
                selection = 0
            }
            
        }
        .font(.system(size: GuessButton.maximumFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
    func view(for code: Code) -> some View {
        HStack {
            CodeView(code: code, gameKind: game.gameKind, selection: $selection)
            Color.clear.aspectRatio(1, contentMode: .fit)
                .overlay {
                    if let matches = code.matches {
                        MatchMarkers(matchs: matches)
                    }else if code.kind == .guess {
                        guessbutton
                    }else if case .master(_) = code.kind {
                        resetGameButton
                    }
                }
        }
    }
    struct GuessButton {
        static let minimumFontSize: CGFloat = 8
        static let maximumFontSize: CGFloat = 80
        static let scaleFactor = minimumFontSize / maximumFontSize
    }
    
}

extension Color {
    static func gray(brightness: Double) -> Color {
        Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

#Preview {
    CodeBreakerView()
}
