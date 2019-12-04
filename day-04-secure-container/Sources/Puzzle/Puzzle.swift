//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 04/12/2019.
//

import Foundation
import AdventKit

public class Puzzle {

    let range: ClosedRange<Int>
    public init(input: String) {
        let lower = Int(input.split(separator: "-")[0])!
        let upper = Int(input.split(separator: "-")[1])!
        self.range = lower...upper
    }

    public func part1() -> Int {
        range.reduce(0) { $0 + (isValid(password: $1) ? 1 : 0)}
    }

    func isValid(password: Int) -> Bool {
        let string = String(password)
        let digits = string.compactMap { $0.wholeNumberValue }

        var containsDouble = false
        var neverDecreases = true

        for i in 1..<digits.count {
            neverDecreases = neverDecreases && (digits[i] >= digits[i-1])
            if !neverDecreases { break }
            containsDouble = containsDouble || (digits[i] == digits[i-1])
        }

        return neverDecreases && containsDouble
    }

    public func part2() -> Int {
        range.reduce(0) { $0 + (isValid2(password: $1) ? 1 : 0)}
    }

    func isValid2(password: Int) -> Bool {
        let string = String(password)
        let digits = string.compactMap { $0.wholeNumberValue }

        var neverDecreases = true
        var pairs = [Int: Int]()
        for i in 1..<digits.count {
            neverDecreases = neverDecreases && (digits[i] >= digits[i-1])
            if !neverDecreases { break }
            if (digits[i] == digits[i-1]) {
                pairs[digits[i], default: 1] += 1
            }
        }

        return neverDecreases && pairs.contains { $0.value == 2 }
    }
}
