//
//  ColorEx.swift
//  WordCodeBreake
//
//  Created by nihaoma3000 on 2026/7/20.
//

import SwiftUI

extension Color {
    init?(named name: String) {
        switch name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
        case "black": self = .black
        case "blue": self = .blue
        case "brown": self = .brown
        case "clear": self = .clear
        case "cyan": self = .cyan
        case "gray", "grey": self = .gray
        case "green": self = .green
        case "indigo": self = .indigo
        case "mint": self = .mint
        case "orange": self = .orange
        case "pink": self = .pink
        case "purple": self = .purple
        case "red": self = .red
        case "teal": self = .teal
        case "white": self = .white
        case "yellow": self = .yellow
        default: return nil
        }
    }
    
    var name: String {
        switch self {
        case .black: "black"
        case .blue: "blue"
        case .brown: "brown"
        case .clear: "clear"
        case .cyan: "cyan"
        case .gray: "gray"
        case .green: "green"
        case .indigo: "indigo"
        case .mint: "mint"
        case .orange: "orange"
        case .pink: "pink"
        case .purple: "purple"
        case .red: "red"
        case .teal: "teal"
        case .white: "white"
        case .yellow: "yellow"
        default: "clear"
        }
    }
}
extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        return Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}
