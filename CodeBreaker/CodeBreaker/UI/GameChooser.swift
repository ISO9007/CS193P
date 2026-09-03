//
//  GameChoose.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/8/27.
//

import SwiftUI

struct GameChooser: View {

    @State private var selection: CodeBreaker?
    
    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            GameList(selection: $selection)
                .navigationTitle("Code breaker")

        } detail: {
            if let selection {
                CodeBreakerView(game: selection)
                    .navigationTitle(selection.name)
                    .navigationBarTitleDisplayMode(.inline)
            }else {
                Text("Choose game")
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    GameChooser()
}
