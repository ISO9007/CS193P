//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/9.
//

import SwiftUI

struct CodeBreakerView: View {
    
    // MARK: Shared data With me
    let game: CodeBreaker
    
    // MARK: Data Owned by me
    @State private var selection: Int = 0
    @State private var restarting = false
    @State private var hideMostRecentMarker = false
    
    // MARK: - body
    var body: some View {
        VStack {
            CodeView(code: game.masterCode)
            ScrollView {
                if !game.isOver {
                    CodeView(code: game.guess, selection: $selection) {
                        Button("Guess", action: guess).fixeibleSystemFont()
                    }
                    .animation(nil, value: game.attempts.count)
                    .opacity(restarting ? 0 : 1)
                    
                }
                
                ForEach(game.attempts, id: \.pegs) { attempt in
                    CodeView(code: attempt) {
                        let showMarker = !hideMostRecentMarker || attempt.pegs != game.attempts.first?.pegs
                        if showMarker, let matches = attempt.matches {
                            MatchMarkers(matchs: matches)
                        }
                    }
                    .transition(.attempt(game.isOver))
                }
                
            }
            if !game.isOver {
                PegChooser(choise: game.pegsChoise, onChoose: changePegAtSelection)
                    .transition(.pegChooser)
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Restart", systemImage: "arrow.circlepath",action: restart)
                    .labelStyle(.automatic)// Button标题或图标显示样式, 默认是automatic
            }
            ToolbarItem {
                ElapsedTimeView(startTime: game.startTime, endTime: game.endTime)
                    .monospaced() // 等宽
                    .lineLimit(1) // 限制一行, 只有等宽文本会换行.
            }
        }
    }
    
    func changePegAtSelection(peg: Peg) {
        game.setGuessPeg(peg: peg, at: selection)
        selection = (selection + 1) % game.guess.pegs.count
    }
    
    func restart() {
        withAnimation(.restart) {
            restarting = game.isOver
            game.restart()
            selection = 0
        } completion: {
            withAnimation(.restart) {
                restarting = false
            }
        }
    }
    
    func guess() {
        withAnimation(.guess) {
            hideMostRecentMarker = true
            game.attemptGuess()
            selection = 0
        } completion: {
            withAnimation(.guess) {
                hideMostRecentMarker = false
            }
        }

    }
}

#Preview {
    @Previewable @State var game = CodeBreaker(name: "Preview", pegsChoise: [.red, .blue, .orange])
    NavigationStack {
        CodeBreakerView(game: game)
    }
}
