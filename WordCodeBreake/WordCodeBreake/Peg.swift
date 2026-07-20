//
//  Peg.swift
//  WordCodeBreake
//
//  Created by nihaoma3000 on 2026/7/20.
//

import Foundation

enum Match: Int {
    case exact = 0
    case inexact = 1
    case nomatch = 2
}

typealias Peg = String
extension Peg {
    static let pegMissing = ""
}


