//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/9.
//

import SwiftUI

struct CodeBreakerView: View {
    // MARK: Data Owned by me
    @State private var game = CodeBreaker(pegsChoise: [.yellow, .gray, .black, .brown, .orange])
    @State private var selection: Int = 0
    @State private var restarting = false
    @State private var hideMostRecentMarker = false
    
    // MARK: - body
    var body: some View {
        VStack {
            Button("Restart", systemImage: "arrow.circlepath",action: restart)
                .labelStyle(.automatic)// Button标题或图标显示样式, 默认是automatic
            CodeView(code: game.masterCode)
            ScrollView {
                if !game.isOver || restarting {
                    CodeView(code: game.guess, selection: $selection) {
                        Button("Guess", action: guess).fixeibleSystemFont()
                    }
                    .animation(nil, value: game.attempts.count)
                    .opacity(restarting ? 0 : 1)
                }
                
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    CodeView(code: game.attempts[index]) {
                        let showMarker = !hideMostRecentMarker || index != game.attempts.count - 1
                        if showMarker, let matches = game.attempts[index].matches {
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
    }
    
    func changePegAtSelection(peg: Peg) {
        game.setGuessPeg(peg: peg, at: selection)
        selection = (selection + 1) % game.guess.pegs.count
    }
    
    func restart() {
        withAnimation(.restart) {
            restarting = true
        } completion: {
            withAnimation(.restart) {
                game.restart()
                selection = 0
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
    CodeBreakerView()
}
