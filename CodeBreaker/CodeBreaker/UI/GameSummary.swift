//
//  GameSummary.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/8/27.
//

import SwiftUI

struct GameSummary: View {
    
    let game: CodeBreaker
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(game.name).font(.title)
            PegChooser(choise: game.pegsChoise)
                .frame(maxHeight: GameSummaryUI.cellMaxHeight)
            // 使用swift ^[...]形态设置语义复数
            Text("^[\(game.attempts.count) attempt](inflect: true)")
        }
    }
}

fileprivate struct GameSummaryUI {
    static let cellMaxHeight: CGFloat = 50
    
}

#Preview {
    GameSummary(game: CodeBreaker(name: "nihoma", pegsChoise: [.blue, .gray, .red, .green]))
}
