//
//  PegView.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/19.
//

import SwiftUI

struct PegView: View {
    // MARK: Data In
    let peg: Peg
    let gameKind: CodeBreaker.Kind
    private let pegShape = Circle()
    
    // MARK: - body
    var body: some View {
        pegShape.overlay {
                if peg == Peg.pegMissing {
                    pegShape.strokeBorder(.gray, lineWidth: 1)
                }else if gameKind == .color {
                    pegShape.foregroundStyle(Color(named: peg) ?? Color.clear)
                }else if gameKind == .emoji {
                    Text(peg)
                        .font(.system(size: 120))
                        .minimumScaleFactor(9 / 120)
                }
            }
            .contentShape(pegShape) // 响应命中形状, 这样就算View是透明颜色也可以响应点击
            .foregroundStyle(.white)
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    PegView(peg: "😇", gameKind: .emoji)
        .padding()
}
