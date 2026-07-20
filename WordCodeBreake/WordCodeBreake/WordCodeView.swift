//
//  WordCodeView.swift
//  WordCodeBreake
//
//  Created by nihaoma3000 on 2026/7/20.
//

import SwiftUI

struct WordCodeView: View {
    
    let code: WordCode
    @Binding var selection: Int
    
    var body: some View {
        ForEach(code.pegs.indices, id: \.self) { index in
            PegView(peg: code.pegs[index], pegMatch: code.matchs?[index] ?? .nomatch)
                .padding(Selection.border)
                .background {
                    if selection == index, code.kind == .guess {
                        Selection.shape
                            .foregroundStyle(Color.gray(0.85))
                    }
                }
                .overlay {
                    Selection.shape
                        .foregroundStyle(code.isHidden ? Color.gray : Color.clear)
                }
                .onTapGesture {
                    withAnimation {
                        if code.kind == .guess {
                            selection = index
                        }
                    }
                   
                }
        }
    }
    
    struct Selection {
        static let border: CGFloat = 5
        static let cornerRadius: CGFloat = 10
        static let color: Color = Color.gray(0.85)
        static let shape = RoundedRectangle(cornerRadius: cornerRadius)
    }
}

