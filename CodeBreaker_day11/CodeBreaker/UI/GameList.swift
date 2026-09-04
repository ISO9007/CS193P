//
//  GameList.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/8/31.
//

import SwiftUI

struct GameList: View {
    
    // MARK: Data Shared with me
    @Binding var selection: CodeBreaker?
    // MARK: Data Owned by me
    @State private var games: [CodeBreaker] = []
    
    var body: some View {
        List(selection: $selection) {
            ForEach(games) { game in
                // 点击导航跳转
                NavigationLink(value: game) {
                    GameSummary(game: game)
                }
                .contextMenu {
                    deleteButton(game: game)
                }
    
            }
            .onDelete { offsets in
                games.remove(atOffsets: offsets)
            }
            .onMove { offset, destination in
                games.move(fromOffsets: offset, toOffset: destination)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .toolbar {
            // 新增游戏
            Button("Add game", systemImage: "plus") {
                withAnimation {
                    let newGame = CodeBreaker(name: "untitled", pegsChoise: [.red, .brown])
                    games.append(newGame)
                }
            }
            // 导航栏按钮
            EditButton()
        }
        .onChange(of: games) { oldValue, newValue in
            if let selection, !newValue.contains(selection) {
                self.selection = nil
            }
        }
        .onAppear { addSamplesGame() }
    }
    
    func deleteButton(game: CodeBreaker) -> some View {
        Button("Delete", systemImage: "minus.circle", role: .destructive) {
            withAnimation {
                games.removeAll { $0 == game }
            }
        }
    }
    
    func addSamplesGame() {
        guard games.isEmpty else {
            return
        }
        games.append(CodeBreaker(name: "Mastermind", pegsChoise: [.blue, .yellow, .green, .pink]))
        games.append(CodeBreaker(name: "Earth Tones", pegsChoise: [.orange, .green, .red, .gray, .blue]))
        games.append(CodeBreaker(name: "Undersea", pegsChoise: [.black, .brown, .gray]))
        selection = games.randomElement()
    }
}

#Preview {
    @Previewable @State var selection: CodeBreaker?
    NavigationStack {
        GameList(selection: $selection)
    }
    
}
