//
//  WordCode.swift
//  WordCodeBreake
//
//  Created by nihaoma3000 on 2026/7/20.
//

import Foundation

struct WordCode {
    
    var pegs: [Peg]
    var kind: Kind
    var pegCount: Int
    
    init(kind: Kind, pegCount: Int) {
        self.pegs = Array(repeating: Peg.pegMissing, count: pegCount)
        self.kind = kind
        self.pegCount = pegCount
    }
    
    var words: String {
        set {
            pegs = newValue.map { String($0) }
            print(newValue)
        }
        get { pegs.joined() }
    }
    
    enum Kind: Equatable {
        case master(isHidden: Bool)
        case guess
        case attempts([Match])
    }
    
    var matchs: [Match]? {
        switch kind {
            case .attempts(let matchs): return matchs
            default: return nil
        }
    }
    
    var isHidden: Bool {
        if case .master(let isHidden) = kind {
            return isHidden
        }
        return false
    }
    
    mutating func reset() {
        pegs = Array(repeating: Peg.pegMissing, count: pegCount)
    }
    
    func match(against otherCode: WordCode) -> [Match] {
        var pegsToMatch = otherCode.pegs
        
        let backwardsExactMatches = pegs.indices.reversed().map { index in
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                pegsToMatch.remove(at: index)
                return Match.exact
            } else {
                return .nomatch
            }
        }
        let exactMatches = Array(backwardsExactMatches.reversed())
        return pegs.indices.map { index in
            if exactMatches[index] != .exact, let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                pegsToMatch.remove(at: matchIndex)
                return .inexact
            } else {
                return exactMatches[index]
            }
        }
    }
    
}

