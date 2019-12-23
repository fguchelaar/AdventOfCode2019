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
        instructions.forEach { instruction in
            switch instruction {
            case .newStack:
                deck.dealIntoNew()
            case .cut(let count):
                deck.cut(count: count)
            case .deal(let with):
                deck.deal(with: with)
            }
        }
        return deck.position(of: 2019)
    }

    public func part2() -> Int {
        let deck = Deck(count: 119_315_717_514_047)
        for _ in 0..<101_741_582_076_661 {
            instructions.forEach { instruction in
                switch instruction {
                case .newStack:
                    deck.dealIntoNew()
                case .cut(let count):
                    deck.cut(count: count)
                case .deal(let with):
                    deck.deal(with: with)
                }
            }
        }
        return deck.position(of: 2020)
    }
}
