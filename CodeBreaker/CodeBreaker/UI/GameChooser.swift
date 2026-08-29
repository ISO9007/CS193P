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
            List {
                ForEach(games) { game in
                    // 点击导航跳转
//                    NavigationLink {
//                        CodeBreakerView(game: game)
//                    } label: {
//                        GameSummary(game: game)
//                    }
                    
                    NavigationLink(value: game) {
                        GameSummary(game: game)
                    }
                    NavigationLink(value: game.masterCode.pegs) {
                        Text("Cheap")
                    }
                }
                .onDelete { offsets in
                    games.remove(atOffsets: offsets)
                }
                .onMove { offset, destination in
                    games.move(fromOffsets: offset, toOffset: destination)
                }
            }
            .listStyle(.plain)
            .toolbar {
                // 导航栏按钮
                EditButton()
            }
            .navigationDestination(for: CodeBreaker.self) { game in
                CodeBreakerView(game: game)
            }
            .navigationDestination(for: [Peg].self) { mastPeg in
                PegChooser(choise: mastPeg)
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
