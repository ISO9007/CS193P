//
//  MatchMarkersPerview.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/14.
//

import SwiftUI


// Mark: - homework
struct MatchMarkersPerview: View {
    var matchs: [Match]
    
    var body: some View {
        HStack {
            ForEach(matchs.indices, id: \.self) { _ in
                Circle()
            }
            matchMarkers
        }
        .frame(height: 50)
    }
    
    var matchMarkers: some View {
        HStack {
            let colCount = Int((Float(matchs.count) / 2).rounded(.up))
            ForEach(0..<colCount, id: \.self) { section in
                sectionMatchMarker(section: section, sectionCount: 2)
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

#Preview("homework") {
    VStack(alignment: .leading, spacing: 20) {
        MatchMarkersPerview(matchs: [])
        MatchMarkersPerview(matchs: [.exact, .exact, .inexact])
        MatchMarkersPerview(matchs: [.exact, .exact, .inexact])
        MatchMarkersPerview(matchs: [.exact, .exact, .exact, .inexact])
        MatchMarkersPerview(matchs: [.exact, .exact, .nomatch, .inexact])
        MatchMarkersPerview(matchs: [.exact, .exact, .nomatch, .inexact, .inexact, .inexact])
        MatchMarkersPerview(matchs: [.exact, .exact, .nomatch, .nomatch, .inexact, .inexact])
        MatchMarkersPerview(matchs: [.exact, .exact, .nomatch, .inexact, .inexact])
        MatchMarkersPerview(matchs: [.exact, .exact, .nomatch, .inexact, .inexact])
    }
    .padding()
    
}
