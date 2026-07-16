//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/9.
//

import SwiftUI

struct CodeBreakerView: View {
    @State var game = CodeBreaker(pegsChoise: [.yellow, .gray, .black, .brown])
    
    var body: some View {
        VStack {
            resetGameButton
            view(for: game.masterCode)
            ScrollView {
                view(for: game.guess)
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
                
            }
        }
        .padding()
    }
    
    var guessbutton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
        }
        .font(.system(size: 80))
        .minimumScaleFactor(0.1) // 按比例缩小, 比如这里80字体,缩小0.1就是8
    }
    
    var resetGameButton: some View {
        Button("Reset Game") {
            withAnimation {
                game.resetGame()
            }
            
        }
        .font(.system(size: 80))
        .minimumScaleFactor(0.1)
    }
    
    func view(for code: Code) -> some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .contentShape(Rectangle()) // 响应命中形状, 这样就算View是透明颜色也可以响应点击
                    .foregroundStyle(code.pegs[index])
                    .aspectRatio(1, contentMode: .fit)
                    .onTapGesture {
                        if code.kind == .guess {
                            game.changeGuessPeg(index)
                        }
                    }
            }
            Rectangle()
                .foregroundStyle(.clear)
                .aspectRatio(1, contentMode: .fit)
                .overlay {
                    if let matches = code.matches {
                        MatchMarkers(matchs: matches)
                    }else if code.kind == .guess {
                        guessbutton
                    }
                }
        }
    }
    
}

#Preview {
    CodeBreakerView()
}

