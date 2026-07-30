//
//  PegChooserView.swift
//  WordCodeBreake
//
//  Created by nihaoma3000 on 2026/7/20.
//

import SwiftUI

struct PegChooserView: View {
    
    let choices: [Peg]
    let onChoose: ((Peg) -> Void)?
    let onGuessClick: (() -> Void)?
    let onBackspace: (() -> Void)?
    let pegChooserMatch: [String: Match]
    
    var body: some View {
        VStack {
            optionButton
            VStack(alignment: .center) {
                keywordView(layoutStart: 0, layoutEnd: 10)
                keywordView(layoutStart: 10, layoutEnd: 10 + 9)
                keywordView(layoutStart: 10 + 9, layoutEnd: choices.count)
            }
            .aspectRatio(10 / 3, contentMode: .fit)
        }
    }
    
    func keywordView(layoutStart: Int, layoutEnd: Int) -> some View {
        HStack {
            ForEach(layoutStart..<layoutEnd, id: \.self) { index in
                Button {
                    onChoose?(choices[index])
                } label: {
                    let peg = choices[index]
                    PegView(peg: choices[index], pegMatch: pegChooserMatch[peg, default: .nomatch])
                        .foregroundStyle(.black)
                }
            }
        }
    }
    
    var optionButton: some View {
        HStack {
            Spacer()
            Button("Guess") {
                onGuessClick?()
            }
            Button("backspace") {
                onBackspace?()
            }
        }
    }
}

#Preview {
    let a = "QWERTYUIOPASDFGHJKLZXCVBNM".map { String($0) }
    PegChooserView(choices: a, onChoose: nil, onGuessClick: nil, onBackspace: nil, pegChooserMatch: [:])
}
