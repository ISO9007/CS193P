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
    
    @State private var gameToEdit: CodeBreaker?
    
    var body: some View {
        List(selection: $selection) {
            ForEach(games) { game in
                // 点击导航跳转
                NavigationLink(value: game) {
                    GameSummary(game: game)
                }
                .contextMenu {
                    editButton(for: game)
                    deleteButton(game: game)
                }
                .swipeActions(edge: .leading) {
                    editButton(for: game).tint(Color.accentColor)
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
            addButton
            // 导航栏按钮
            EditButton()
        }
        .onChange(of: games) {
            if let selection, !games.contains(selection) {
                self.selection = nil
            }
        }
        .onAppear { addSamplesGame() }
    }
    
    var addButton: some View {
        Button("Add game", systemImage: "plus") {
            gameToEdit = CodeBreaker(name: "untitled", pegsChoise: [.red, .brown])
        }
//        .onChange(of: gameToEdit) {
//            showGameEdit = gameToEdit != nil
//        }
        .sheet(isPresented: showGameEdit) {
            gameEditor
        }
    }
    
    // 利用Binding将触发sheet的变量状态和gameToEit状态互相绑定
    var showGameEdit: Binding<Bool> {
        Binding<Bool> {
            // 根据gameToEdit状态返回是否触发sheet
            gameToEdit != nil
        } set: { newValue in
            // sheet写入状态时通知gameToEdit改变状态
            if !newValue {
                gameToEdit = nil
            }
        }
    }
    

    
    func editButton(for game: CodeBreaker) -> some View {
        Button("Edit", systemImage: "pencil") {
            gameToEdit = game
        }
    }
    
    @ViewBuilder
    var gameEditor: some View {
        if let gameToEdit {
            let copyGameEdit = CodeBreaker(name: gameToEdit.name, pegsChoise: gameToEdit.pegsChoise)
            GameEditor(game: gameToEdit) {
                if let index = games.firstIndex(of: gameToEdit) {
                    // 编辑已存在的CodeBreak
                    games[index] = copyGameEdit
                }else {
                    // 新增的CodeBreak
                    games.insert(gameToEdit, at: 0)
                }
            }
        }
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
