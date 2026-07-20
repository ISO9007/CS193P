//
//  ChooiseView.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/19.
//

import SwiftUI

struct PegChooser: View {
    // MARK: Data In
    let choise: [Peg]
    let gameKind: CodeBreaker.Kind
    // MARK: Data Out Funtion
    let onChoose: ((Peg) -> Void)?
    
    // MARK: - body
    var body: some View {
        HStack {
            ForEach(choise, id: \.self) { peg in
                Button {
                    onChoose?(peg)
                } label: {
                    PegView(peg: peg, gameKind: gameKind)
                }
            }
        }
    }
}
