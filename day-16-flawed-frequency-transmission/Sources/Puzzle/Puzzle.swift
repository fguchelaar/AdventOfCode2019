//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 30/11/2019.
//

import Foundation
import AdventKit

public class Puzzle {

    let input: String
    public init(input: String) {
        self.input = input
    }

    var patternMap = [Int: [Int]]()

    /// Gets the pattern for the _n-th_ digit. Uses caching for performance
    func pattern(for digit: Int) -> [Int] {
        if let pattern = patternMap[digit] {
            return pattern
        } else {
            let base = [0,1,0,-1]
            var pattern = base.flatMap {
                Array<Int>(repeating: $0, count: digit+1)
            }
            pattern.append(pattern.removeFirst())
            patternMap[digit] = pattern
            return pattern
        }
    }

    func apply(phases: Int) -> String {
        var signal = input.compactMap { $0.wholeNumberValue }
        (0..<phases).forEach { phase in
            for row in 0..<signal.count {
                let pattern = self.pattern(for: row)
                var number = 0
                for col in row..<signal.count {
                    number += signal[col] * pattern[(col) % pattern.count]
                }
                signal[row] = abs(number) % 10
            }
        }
        return signal.map { String($0) }.joined()
    }

    public func part1() -> String {
        String(apply(phases: 100).prefix(8))
    }

    public func part2() -> String {

        let repeated = Array<String>(repeating: input, count: 10_000).joined()
        let offset = Int(input.prefix(7))!

        var signal = repeated.compactMap { $0.wholeNumberValue }
        var nextSignal = signal

        let numPhases = 100
        for _ in 0..<numPhases {

            var index = signal.count - 2
            nextSignal[index + 1] = signal[index + 1]
            while index >= offset {
                nextSignal[index] = (nextSignal[index + 1] + signal[index]) % 10
                index -= 1
            }
            signal = nextSignal
        }
        return signal[offset..<offset+8].map { String($0) }.joined()
    }
}
