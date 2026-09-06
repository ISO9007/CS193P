//
//  PegChoicesChooser.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/9/4.
//

import SwiftUI

struct PegChoicesChooser: View {
    
    //MARK: Data shared with me
    @Binding var pegsChoise: [Peg]
    
    var body: some View {
        List() {
            ForEach(pegsChoise.indices, id: \.self) { index in
                ColorPicker(
                    selection: $pegsChoise[index],
                    supportsOpacity: false,
                ) {
                    button("Peg Choise \(index + 1)", systemImage: "minus.circle", color: .red) {
                        pegsChoise.remove(at: index)
                    }
                }
            }
            
            button("Add Peg", systemImage: "plus.circle", color: .green) {
                pegsChoise.append(.red)
            }
        }
    }
    
    func button(
        _ title: String,
        systemImage: String,
        color: Color?,
        onAction: @escaping () -> Void
    ) -> some View {
        HStack {
            Button {
                withAnimation {
                    onAction()
                }
            } label: {
                Image(systemName: systemImage)
            }.tint(color)
            Text(title)
        }
    }
}

#Preview {
    @Previewable @State var pegsChoise: [Peg] = [.red, .green]
    PegChoicesChooser(pegsChoise: $pegsChoise)
        .onChange(of: pegsChoise) {
            print("change pegs: \(pegsChoise)")
        }
}
