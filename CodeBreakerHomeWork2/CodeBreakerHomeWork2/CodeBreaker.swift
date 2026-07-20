//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by nihaoma3000 on 2026/7/14.
//

import SwiftUI


// 游戏逻辑模型
struct CodeBreaker {
    
    var gameKind: Kind
    var masterCode: Code
    var guess: Code
    var attempts: [Code] = []
    var pegsCount: Int
    var pegsChoise: [Peg]
    let gameTheme: GameTheme = GameTheme()
    
    init(
        pegsCount: Int = 4,
        gameKind: Kind = .emoji,
        pegsChoise: [Peg] = []
    )
    {
        self.gameKind = gameKind
        self.pegsChoise = pegsChoise
        self.pegsCount = pegsCount
        masterCode = Code(kind: .master(isHidden: true), pegsCount: pegsCount, gameKind: gameKind)
        guess = Code(kind: .guess, pegsCount: pegsCount, gameKind: gameKind)
        masterCode.randomize(from: pegsChoise)
        print(masterCode)
    }
    
    enum Kind {
        case color
        case emoji
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
    
    mutating func randomize() {
        pegsCount = Int.random(in: 3...6)
        gameKind = Bool.random() ? Kind.color : Kind.emoji
        if gameKind == .color {
            pegsChoise = gameTheme.randomizeColor()
        }else {
            pegsChoise = gameTheme.randomizeEmoji()
        }
    }
    
    mutating func resetGame() {
        randomize()
        masterCode = Code(kind: .master(isHidden: true), pegsCount: pegsCount, gameKind: gameKind)
        guess = Code(kind: .guess, pegsCount: pegsCount, gameKind: gameKind)
        masterCode.randomize(from: pegsChoise)
        attempts.removeAll()
        guess.pegs = Array(repeating: Peg.pegMissing, count: pegsCount)
        print(masterCode)
    }
}

struct GameTheme {
    
    let colorTheme: [String: [Color]] = [
        "one": [
            Color.red, Color.green ,Color.blue
        ],
        "two": [Color.blue, Color.green, Color.red, Color.yellow],
        "three": [Color.blue, Color.black, Color.pink, Color.brown],
    ]
    
    let emojiTheme: [String: [Peg]] = [
        "one": ["🥹", "😀", "🥳", "🤪", "😨"],
        "two": ["🚗", "🚲","🛩", "⛵"],
        "three": ["🐶", "🐱", "🦊", "🐻", "🐼"],
    ]
    
    func randomizeColor() -> [Peg] {
        guard let key = colorTheme.keys.randomElement() else {
            return [Color.red.name]
        }
        
        return colorTheme[key]!.map { $0.name }
    }
    
    func randomizeEmoji() -> [Peg] {
        guard let key = emojiTheme.keys.randomElement() else {
            return ["😀"]
        }
        
        return emojiTheme[key]!
    }
}






