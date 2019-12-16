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

            var next = [Int]()
            for row in 0..<signal.count {
                let pattern = self.pattern(for: row)
                let number =
                    signal.enumerated()
                        .map { (offset, element) in
                            return element * pattern[offset % pattern.count]
                    }
                    .reduce(0, +)
                next.append(abs(number) % 10)
            }
            signal = next
        }
        return signal.map { String($0) }.joined()
    }

    public func part1() -> String {
        String(apply(phases: 100).prefix(8))
    }


    func apply(phases: Int, to: String) -> String {

        var signal = to.compactMap { $0.wholeNumberValue }
        (0..<phases).forEach { phase in
            print("START PHASE \(phase)")
            var next = [Int]()
            for row in 0..<signal.count {
                let pattern = self.pattern(for: row)
                let number =
                    signal.enumerated()
                        .map { (offset, element) in
                            return element * pattern[offset % pattern.count]
                    }
                    .reduce(0, +)
                next.append(abs(number) % 10)
            }
            signal = next
            print("END PHASE \(phase)")
        }
        return signal.map { String($0) }.joined()
    }

    public func part2() -> String {
        let repeated = Array<String>(repeating: input, count: 2).joined()
        let output = apply(phases: 10, to: repeated)
        let offset = Int(output.prefix(8))!

        let start = output.index(repeated.startIndex, offsetBy: offset)
        let end = output.index(repeated.startIndex, offsetBy: offset+8)
        let range = start..<end
        return String(output[range])
    }
}
