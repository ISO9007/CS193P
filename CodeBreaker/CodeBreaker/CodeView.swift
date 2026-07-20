//
//  CodeView.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/19.
//


import SwiftUI

struct CodeView: View {
    // MARK: Data In
    let code: Code
    // MARK: Data
    @Binding var selection: Int
    
    // MARK: - body
    var body: some View {
        ForEach(code.pegs.indices, id: \.self) { index in
            PegView(peg: code.pegs[index])
                .padding(Selection.border)
                .background {
                    if code.kind == .guess, selection == index {
                        Selection.shape
                            .foregroundStyle(Selection.color)
                    }
                }
                .overlay(
                    Selection.shape.foregroundStyle(code.isHidden ? Color.gray : Color.clear)
                )
                .onTapGesture {
                    if code.kind == .guess {
                        selection = index
                    }
                }
        }
    }
    
    // 选择器常量, 集中管理魔法数字
    struct Selection {
        static let border: CGFloat = 5
        static let cornerRadiues: CGFloat = 10
        static let color: Color = Color.gray(brightness: 0.85)
        static let shape = RoundedRectangle(cornerRadius: Selection.cornerRadiues, style: .continuous)
    }
}
