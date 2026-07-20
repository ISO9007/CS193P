//
//  Code.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/19.
//


import SwiftUI

// 密码
struct Code {
    // MARK: Data in
    var pegs: [Peg] = Array(repeating: Peg.pegMissing, count: 4)
    var kind: Kind
    
    
    enum Kind: Equatable {
        case master(isHidden: Bool)
        case guess
        case attempt([Match])
        case unknown
    
    }
    
    var isHidden: Bool {
        if case .master(let isHidden) = kind {
            return isHidden
        }
        return false
    }
    
    mutating func randomize(from pegChoise: [Peg]) {
        for index in pegs.indices {
            pegs[index] = pegChoise.randomElement() ?? Peg.pegMissing
        }
    }
    
    mutating func reset() {
        pegs = Array(repeating: Peg.pegMissing, count: 4)
    }
    
    var matches: [Match]? {
        switch kind {
        case .attempt(let matchs): return matchs
        default: return nil
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        var result: [Match] = Array(repeating: .nomatch, count: pegs.count)
        var pegsToMatch = otherCode.pegs
        // 先计算精确匹配的
        for index in pegs.indices.reversed() {
            if index < otherCode.pegs.count,
               pegs[index] == pegsToMatch[index] {
                result[index] = .exact
                pegsToMatch.remove(at: index)
            }
        }
        // 再计算颜色匹配
        for index in pegs.indices {
            if result[index] != .exact{
                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                    result[index] = .inexact
                    pegsToMatch.remove(at: matchIndex)
                }
            }
        }
        return result
    }
}
