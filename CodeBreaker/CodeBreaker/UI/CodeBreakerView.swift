//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/9.
//

import SwiftUI

struct CodeBreakerView: View {
    // MARK: Data Owned by me
    @State private var game = CodeBreaker(pegsChoise: [.yellow, .gray, .black, .brown])
    @State private var selection: Int = 0
    
    // MARK: - body
    var body: some View {
        VStack {
            CodeView(code: game.masterCode)
            ScrollView {
                if !game.isOver {
                    CodeView(code: game.guess, selection: $selection) {
                        guessbutton
                    }
                }
                
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    CodeView(code: game.attempts[index]) {
                        if let matches = game.attempts[index].matches {
                            MatchMarkers(matchs: matches)
                        }
                    }
                }
                
            }
            PegChooser(choise: game.pegsChoise) { peg in
                game.setGuessPeg(peg: peg, at: selection)
                selection = (selection + 1) % game.guess.pegs.count
            }

        }
        .padding()
    }
    
    var guessbutton: some View {
        Button("Guess") {
            
            withAnimation(.linear(duration: 30)) {
                // 设置状态变化
            } completion: {
                // 动画完成后
            }

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

extension Color {
    static func gray(brightness: Double) -> Color {
        Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

#Preview {
    CodeBreakerView()
}
