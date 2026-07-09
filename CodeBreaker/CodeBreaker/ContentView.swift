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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Circle()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
