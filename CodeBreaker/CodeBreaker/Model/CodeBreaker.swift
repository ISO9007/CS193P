//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/14.
//

import SwiftUI


// 游戏逻辑模型
@Observable class CodeBreaker: Identifiable {
    
    let name: String
    var masterCode: Code = Code(kind: .master(isHidden: true))
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = []
    let pegsChoise: [Peg]
    var startTime: Date = .now
    var endTime: Date?
    
    init(name: String, pegsChoise: [Peg] = [.red, .yellow, .blue, .green]) {
        self.name = name
        self.pegsChoise = pegsChoise
        masterCode.randomize(from: pegsChoise)
    }
    
    var isOver: Bool {
        attempts.first?.pegs == masterCode.pegs
    }

    func setGuessPeg(peg: Peg, at index: Int) {
        guard guess.pegs.indices.contains(index) else { return }
        guess.pegs[index] = peg
    }
    
    // 暂时没用,自动获取下一个Peg
    func changeGuessPeg(_ index: Int) {
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegsChoise = pegsChoise.firstIndex(of: existingPeg) {
            guess.pegs[index] = pegsChoise[(indexOfExistingPegsChoise + 1) % pegsChoise.count]
        }else {
            guess.pegs[index] = pegsChoise.first ?? Peg.pegMissing
        }
    }
    
    func attemptGuess() {
        var guessCode = guess
        if guessCode.pegs.contains(Peg.pegMissing) || attempts.contains(where: { $0.pegs == guessCode.pegs })  {
            return
        }
        guessCode.kind = .attempt(guessCode.match(against: masterCode))
        attempts.insert(guessCode, at: 0)
        guess.reset()
        if isOver {
            endTime = .now
            masterCode.kind = .master(isHidden: false)
        }
    }
    
    func restart() {
        masterCode = Code(kind: .master(isHidden: true))
        masterCode.randomize(from: pegsChoise)
        guess.reset()
        attempts.removeAll()
        startTime = .now
        endTime = nil
    }
}
extension CodeBreaker: Hashable {
    static func == (lst: CodeBreaker, rst: CodeBreaker) -> Bool {
        lst.id == rst.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


