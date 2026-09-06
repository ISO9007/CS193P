//
//  ElapsedTimeView.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/8/1.
//

import SwiftUI

// 每局游戏时间
struct ElapsedTimeView: View {
    let startTime: Date?
    let endTime: Date?
    let elapsedTime: TimeInterval
    
    var format: SystemFormatStyle.DateOffset {
        .offset(to: startTime! - elapsedTime, allowedFields: [.minute, .second])
    }
    
    var body: some View {
        if startTime != nil {
            if let endTime = endTime {
                Text(endTime, format: format)
            }else {
                // Text持续更新时间
                Text(TimeDataSource<Date>.currentDate, format: format)
                
                // body不会重新计算, 时间不会动. 因为游戏未结束每次传入startTime和endTime都一样, swiftUI判断struct值没变化.
                // Text(Date.now, format: .offset(to: startTime, allowedFields: [.minute, .second]))
            }
        }else {
            Image(systemName: "pause")
        }

    }
}
