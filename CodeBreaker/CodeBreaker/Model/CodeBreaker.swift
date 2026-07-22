//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/14.
//

import SwiftUI


// 游戏逻辑模型
struct CodeBreaker {
    var masterCode: Code = Code(kind: .master(isHidden: true))
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = []
    let pegsChoise: [Peg]
    
    init(pegsChoise: [Peg] = [.red, .yellow, .blue, .green]) {
        self.pegsChoise = pegsChoise
        masterCode.randomize(from: pegsChoise)
        print(masterCode)
    }
    
    var isOver: Bool {
        attempts.last?.pegs == masterCode.pegs
    }

    mutating func setGuessPeg(peg: Peg, at index: Int) {
        guard guess.pegs.indices.contains(index) else { return }
        guess.pegs[index] = peg
    }
    
    mutating func changeGuessPeg(_ index: Int) {
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegsChoise = pegsChoise.firstIndex(of: existingPeg) {
            guess.pegs[index] = pegsChoise[(indexOfExistingPegsChoise + 1) % pegsChoise.count]
        }else {
            guess.pegs[index] = pegsChoise.first ?? Peg.pegMissing
        }
    }
    
    mutating func attemptGuess() {
        var guessCode = guess
        if guessCode.pegs.contains(Peg.pegMissing) || attempts.contains(where: { $0.pegs == guessCode.pegs })  {
            return
        }
        guessCode.kind = .attempt(guessCode.match(against: masterCode))
        attempts.append(guessCode)
        guess.reset()
        if isOver {
            masterCode.kind = .master(isHidden: false)
        }
    }
    
    mutating func resetGame() {
        masterCode.randomize(from: pegsChoise)
        guess.pegs = Array(repeating: Peg.pegMissing, count: 4)
        attempts.removeAll()
    }
}





