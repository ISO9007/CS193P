//
//  WordCodeBreake.swift
//  WordCodeBreake
//
//  Created by nihaoma3000 on 2026/7/20.
//

import Foundation

struct WordCodeBreake {
    var masterCode: WordCode
    var guessCode: WordCode
    var attempts: [WordCode] = []
    var pegChoices: [Peg]
    var pegCount: Int
    var pegChooserMatch: [String: Match] = [:]
    
    init(pegCount: Int = 5) {
        self.pegCount = pegCount
        self.masterCode = WordCode(kind: .master(isHidden: true), pegCount: pegCount)
        self.guessCode = WordCode(kind: .guess, pegCount: pegCount)
        self.pegChoices = "QWERTYUIOPASDFGHJKLZXCVBNM".map { String($0) }
        self.pegChoices.forEach { w in
            pegChooserMatch[w] = .nomatch
        }
    }
    
    var isOver: Bool {
        attempts.last?.pegs == masterCode.pegs
    }
    
    mutating func attemptGuess() {
        var attempt = guessCode
        attempt.kind = .attempts(attempt.match(against: masterCode))
        attempts.append(attempt)
        attemptPegChooserMatch(attempt: attempt)
        guessCode = WordCode(kind: .guess, pegCount: pegCount)
        if isOver {
            masterCode.kind = .master(isHidden: false)
        }
    }
    
    mutating func attemptPegChooserMatch(attempt: WordCode) {
        let matchs = attempt.matchs!
        attempt.pegs.indices.forEach { index in
            let peg = attempt.pegs[index]
            let match = matchs[index]
            if let pegMatch = pegChooserMatch[peg] {
                if match.rawValue < pegMatch.rawValue {
                    pegChooserMatch[peg] = match
                }
                
            }
        }
    }
    
    mutating func setGuessCode(_ peg: Peg, at index: Int) {
        guard guessCode.pegs.indices.contains(index) else {
            return 
        }
        guessCode.pegs[index] = peg
    }
    
    mutating func reset(_ pegCount: Int? = nil) {
       if let pegCount = pegCount {
           self.pegCount = pegCount
       }
       self.masterCode = WordCode(kind: .master(isHidden: true), pegCount: self.pegCount)
       self.guessCode = WordCode(kind: .guess, pegCount: self.pegCount)
       self.attempts = []
        self.pegChoices.forEach { w in
            pegChooserMatch[w] = .nomatch
        }
    }
}

