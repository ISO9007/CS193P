//
//  GameEditor.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/8/31.
//

import SwiftUI

struct GameEditor: View {
    // 获取关闭sheet modal环境变量
    // MARK: Data In
    @Environment(\.dismiss) private var dismiss
    
    // MARK: Data shared with me
    @Bindable var game: CodeBreaker
    
    // MARK: Data owned by me
    @State private var showInvalidGameAlert = false
    
    //MARK: Action Function
    let onChoose: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("NAME") {
                    TextField("Game Name", text: $game.name)
                        .onSubmit {
                            done()
                        }
                }
                Section("PEGS") {
                    PegChoicesChooser(pegsChoise: $game.pegsChoise)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        done()
                    }
                    .alert("Invalid game", isPresented: $showInvalidGameAlert) {
                        Button("Ok") {
                            showInvalidGameAlert = false
                        }
                    } message: {
                        Text("A game must have a name and more one unique pegs")
                    }
                }
            }
        }

    }
    
    func done() {
        if game.isValid {
            onChoose()
            dismiss()
        }else {
            showInvalidGameAlert = true
        }
    }
    
}

extension CodeBreaker {
    var isValid: Bool {
        !name.isEmpty && Set(pegsChoise).count >= 2
    }
}

#Preview {
    @Previewable var game: CodeBreaker = CodeBreaker(name: "PreviewGame", pegsChoise: [.red, .blue])
    GameEditor(game: game) {
        print("游戏名字发生改变 -> \(game.name)")
        print("游戏选择钉子改变 -> \(game.pegsChoise)")
    }
}
