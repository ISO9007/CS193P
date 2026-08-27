//
//  GameChoose.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/8/27.
//

import SwiftUI

struct GameChooser: View {
    // MARK: Data Owned by me
    @State private var games: [CodeBreaker] = []
    
    var body: some View {
        NavigationStack {
            List($games, id: \.pegsChoise, editActions: [.delete, .move]) { $game in
                // 点击导航跳转
                NavigationLink {
                    CodeBreakerView(game: $game)
                } label: {
                    GameSummary(game: game)
                }
            }
            .listStyle(.plain)
            .toolbar {
                // 导航栏按钮
                EditButton()
            }
        }
        .onAppear {
            games.append(CodeBreaker(name: "Mastermind", pegsChoise: [.blue, .yellow, .green, .pink]))
            games.append(CodeBreaker(name: "Earth Tones", pegsChoise: [.orange, .green, .red, .gray, .blue]))
            games.append(CodeBreaker(name: "Undersea", pegsChoise: [.black, .brown, .brown]))
        }
    }
}

#Preview {
    GameChooser()
}
