//
//  ContentView.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/9.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            pegs(colors: [.red, .green, .blue, .orange])
            pegs(colors: [.red, .green, .green, .orange])
            pegs(colors: [.yellow, .green, .blue, .orange])
            pegs(colors: [.brown, .green, .blue, .pink])
        }
        .padding()
    }
    
    func pegs(colors: [Color]) -> some View {
        HStack {
            ForEach(colors.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(colors[index])
                    .aspectRatio(1, contentMode: .fit)
            }
            MatchMarkers(matchs: [.exact, .exact, .nomatch, .inexact])
        }
    }
    
}

#Preview {
    ContentView()
}

