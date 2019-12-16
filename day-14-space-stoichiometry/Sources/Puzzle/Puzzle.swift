//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 30/11/2019.
//

import Foundation
import AdventKit

public class Puzzle {

    let reactions: [Reaction]
    public init(input: String) {
        self.reactions =
            input.array(separatedBy: .newlines, using: Puzzle.parse(reaction:))
    }

    class func parse(reaction: String) -> Reaction {
        let parts = reaction
            .components(separatedBy: CharacterSet(charactersIn: ", =>"))
            .filter { !$0.isEmpty }

        let inputs = stride(from: 0, to: parts.count-2, by: 2)
            .reduce(into: [String: Int]()) {
                $0[parts[$1+1]] = Int(parts[$1])!
        }

        let output = parts.last!
        let amount = Int(parts.suffix(2).first!)!

        return Reaction(inputs: inputs, output: output, amount: amount)
    }

    public func part1() -> Int {
        let factory = NanoFactory(reactions: reactions)
        factory.requestFuel(amount: 1)
        return factory.requested["ORE"]!
    }

    public func part2() -> Int {
        var min = 1
        var max = 1_000_000_000_000
        var guess = max
        while min != max {
            let factory = NanoFactory(reactions: reactions)
            guess = Int(ceil((Double(min) + Double(max)) / 2.0))
            factory.requestFuel(amount: guess)
            let ore = factory.requested["ORE"]!

            if ore > 1_000_000_000_000 {
                max = guess - 1
            } else {
                min = guess
            }
        }
        return min
    }
}
