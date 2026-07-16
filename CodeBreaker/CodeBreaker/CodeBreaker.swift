//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/14.
//

import SwiftUI


// 游戏逻辑模型
struct CodeBreaker {
    var masterCode: Code = Code(kind: .master)
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = []
    let pegsChoise: [Peg]
    
    init(pegsChoise: [Peg] = [.red, .yellow, .blue, .green]) {
        self.pegsChoise = pegsChoise
        masterCode.randomize(from: pegsChoise)
        print(masterCode)
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
    }
    
    mutating func resetGame() {
        masterCode.randomize(from: pegsChoise)
        guess.pegs = Array(repeating: Peg.pegMissing, count: 4)
        attempts.removeAll()
    }
}

// 密码
struct Code {
    var pegs: [Peg] = Array(repeating: Peg.pegMissing, count: 4)
    var kind: Kind
    
    
    
    enum Kind: Equatable {
        case master
        case guess
        case attempt([Match])
        case unknown
    
    }
    
    mutating func randomize(from pegChoise: [Peg]) {
        for index in pegs.indices {
            pegs[index] = pegChoise.randomElement() ?? Peg.pegMissing
        }
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

// 目前考虑Peg只有颜色一个属性,使用typealias
typealias Peg = Color
extension Peg {
    static let pegMissing: Peg = .clear
}
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
    
    var name: String? {
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
        default: nil
        }
    }
}
