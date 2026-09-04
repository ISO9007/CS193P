//
//  GameEditor.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/8/31.
//

import SwiftUI

struct GameEditor: View {
    
    @Bindable var game: CodeBreaker
    
    var body: some View {
        Form {
            Section("NAME") {
                TextField("Game Name", text: $game.name)
            }
            Section("PEG") {
                List(game.pegsChoise.indices, id: \.self) { index in
                    ColorPicker(
                        selection: $game.pegsChoise[index],
                        supportsOpacity: false,
                    ) {
                        Text("Peg Choise \(index + 1)")
                    }
                    
                }
            }
        }
    }
}

#Preview {
    @Previewable var game: CodeBreaker = CodeBreaker(name: "PreviewGame", pegsChoise: [.red, .blue])
    GameEditor(game: game)
        .onChange(of: game.name) {
            print("游戏名字发生改变 -> \(game.name)")
        }
        .onChange(of: game.pegsChoise) {
            print("游戏选择钉子改变 -> \(game.pegsChoise)")
        }
}
