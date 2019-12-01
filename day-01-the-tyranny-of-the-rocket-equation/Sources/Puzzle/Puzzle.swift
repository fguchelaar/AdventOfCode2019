//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 30/11/2019.
//

import Foundation
import AdventKit

public class Puzzle {

    let input: [Int]
    public init(input: String) {
        self.input = input.intArray  
    }

    public func part1() -> Int {
        input
            .map(requiredFuel(for:))
            .reduce(0, +)
    }

    public func part2() -> Int {
        input
            .map (totalRequiredFuel(for:))
            .reduce(0, +)
    }

    func requiredFuel(for mass: Int) -> Int {
        mass / 3 - 2
    }

    func totalRequiredFuel(for mass: Int) -> Int {
        var total = 0
        var fuel = requiredFuel(for: mass)
        while fuel > 0 {
            total += fuel
            fuel = requiredFuel(for: fuel)
        }
        return total
    }
}
