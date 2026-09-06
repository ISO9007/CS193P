//
//  UIExtension.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/30.
//

import SwiftUI

extension Animation {
    static let codeBreaker = Animation.bouncy
    static let guess = Animation.codeBreaker
    static let restart = Animation.codeBreaker
    static let selection = Animation.codeBreaker
}

extension AnyTransition {
    static let pegChooser = AnyTransition.offset(x: 0, y: 200)
    static func attempt(_ isOver: Bool) -> AnyTransition {
        AnyTransition.asymmetric(
            insertion: isOver ? .opacity : .move(edge: .top),
            removal: .move(edge: .trailing)
        )
    }
}

extension View {
    func fixeibleSystemFont(_ maxinium: CGFloat = 80, _ minium: CGFloat = 8) -> some View {
        self.font(.system(size: maxinium))
            .minimumScaleFactor(minium / maxinium) // 按比例缩小, 比如这里80字体,缩小0.1就是8
    }
}

extension Color {
    static func gray(brightness: Double) -> Color {
        Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

