//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/10.
//

import SwiftUI

enum Match {
    case exact // 位置和颜色都命中
    case inexact // 颜色正确中,但位置不准确
    case nomatch // 全都不中
}

// 符合游戏要求的标记
struct MatchMarkers: View {
    
    var matchs: [Match]
    
    var body: some View {
        HStack {
            if matchs.isEmpty {
                matchMarker(peg: 0)
            }else {
                let colCount = Int((Float(matchs.count) / 2).rounded(.up))
                ForEach(0..<colCount, id: \.self) { section in
                    sectionMatchMarker(section: section, sectionCount: 2)
                }
            }

        }
    }
    
    func sectionMatchMarker(section: Int, sectionCount: Int) -> some View {
        VStack {
            ForEach(0..<sectionCount, id: \.self) { index in
                matchMarker(peg: index + section * sectionCount)
            }
        }
    }
    
    func matchMarker(peg: Int) -> some View {
        // 精准个数
        let exactCount: Int = matchs.count { $0 == .exact }
        // 正确个数
        let foundCount: Int = matchs.count { $0 != .nomatch }
        // 先将全中的画出来, 再画正确的
        return Circle()
                .fill(exactCount > peg ? Color.primary : Color.clear)
                .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 1)
                // strokeBorder是普通view,不是Shape, 宽高比不会默认1
                //strokeBorder会将边框画在圆内,stroke是画在圆外
                .aspectRatio(1, contentMode: .fit)
    }
}




#Preview {
    MatchMarkers(matchs: [.exact, .exact, .inexact, .nomatch, .exact, .exact])
}


