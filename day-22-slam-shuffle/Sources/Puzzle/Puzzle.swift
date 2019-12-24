//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 30/11/2019.
//

import Foundation
import AdventKit

public class Puzzle {

    enum Shuffle {
        case newStack
        case cut(count: Int)
        case deal(with: Int)

        func apply(to deck: Deck) {
            switch self {
            case .newStack:
                deck.dealIntoNew()
            case .cut(let count):
                deck.cut(count: count)
            case .deal(let with):
                deck.deal(with: with)
            }
        }
    }

    let instructions: [Shuffle]
    public init(input: String) {
        self.instructions = input.trimmingCharacters(in:
            .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map (Puzzle.parse(instruction:))
    }

    static func parse(instruction: String) -> Shuffle {
        if instruction == "deal into new stack" {
            return .newStack
        } else if instruction.starts(with: "cut") {
            let count = Int(instruction.split(separator: " ").last!)!
            return .cut(count: count)
        } else if instruction.starts(with: "deal with") {
            let count = Int(instruction.split(separator: " ").last!)!
            return .deal(with: count)
        } else {
            fatalError()
        }
    }

    public func part1() -> Int {
        let deck = Deck(count: 10_007)
        instructions.forEach { $0.apply(to: deck) }
        return deck.position(of: 2019)
    }

    func power(_ x: BInt, _ y: BInt, _ m: BInt) -> BInt {
        if y == 0 { return 1 }
        var p = power(x, y / 2, m) % m
        p = (p * p) % m
        return y.isEven() ? p : (x * p) % m
    }

    func primeModInverse(_ a: BInt, _ m: BInt) -> BInt {
        return power(a, m - 2, m)
    }

    func applyInverse(shuffle: Shuffle, to position: BInt, with deckSize: BInt) -> BInt {
        switch shuffle {
        case .newStack:
            return deckSize - 1 - position
        case .cut(let count):
            return (position + BInt(count) + deckSize) % deckSize
        case .deal(let with):
            return primeModInverse(BInt(with), deckSize) * position % deckSize
        }
    }

    public func part2() -> Int {

        let d = BInt(119_315_717_514_047)
        let n = BInt(101_741_582_076_661)
        let x = BInt(2020)

        let y = instructions.reversed()
            .reduce(x) { applyInverse(shuffle: $1, to: $0, with: d) }

        let z = instructions.reversed()
            .reduce(y) { applyInverse(shuffle: $1, to: $0, with: d) }

        let a = (y - z) * primeModInverse(x - y + d, d) % d
        let b = (y - a * x) % d

        let answer = (power(a, n, d) * x + (power(a, n, d) - 1) * primeModInverse(a - 1, d) * b) % d

        return Int(answer)
    }
}
