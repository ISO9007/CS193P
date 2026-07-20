//
//  PegView.swift
//  WordCodeBreake
//
//  Created by nihaoma3000 on 2026/7/20.
//

import SwiftUI

struct PegView: View {
    
    let peg: Peg
    let pegMatch: Match
    let pegShape = RoundedRectangle(cornerRadius: 10)
    
    var body: some View {
        pegShape
            .fill(pegColor)
            .strokeBorder()
            .overlay {
                Text(peg)
                    .font(.system(size: 80))
                    .minimumScaleFactor(8 / 80)
            }
            .aspectRatio(contentMode: .fit)
    }
    
    var pegColor: Color {
        switch pegMatch {
        case .exact:
            return Color.yellow
        case .inexact:
            return Color.brown
        case .nomatch:
            return Color.white
        }
    }
}

#Preview {
    PegView(peg: "d", pegMatch: .exact)
        .padding()
}
