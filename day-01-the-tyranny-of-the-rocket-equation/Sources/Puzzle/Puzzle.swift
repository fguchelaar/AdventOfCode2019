//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 01/12/2019.
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
        let fuel = requiredFuel(for: mass)
        return fuel >= 0 ? fuel + totalRequiredFuel(for: fuel) : 0
    }
}
