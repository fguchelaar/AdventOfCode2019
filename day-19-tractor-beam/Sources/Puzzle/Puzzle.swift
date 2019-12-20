//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 30/11/2019.
//

import Foundation
import AdventKit

public class Puzzle {
    
    let program: [Int]
    public init(input: String) {
        self.program = input.array(separatedBy: CharacterSet(charactersIn: ","), using: Int.init)
    }
    
    func isAffected(x: Int, y: Int) -> Bool {
        let ic = IntCode(memory: program)
        ic.runProgram(inputs: [x, y])
        return ic.output[0] == 1
    }

    /// Simply brute-force all coordinates
    public func part1() -> Int {
        var affected = 0
        for y in 0..<50 {
            for x in 0..<50 {
                let ic = IntCode(memory: program)
                ic.runProgram(inputs: [x, y])
                if ic.output[0] == 1 {
                    affected += 1
                }
            }
        }
        return affected
    }

    /// By starting at 99 I know we won't find anything, but what if it's a real strong beam :)
    public func part2() -> Int {
        var startAt = 0
        var y = 99
        row: while y < Int.max {
            for x in startAt...y-99 {
                if isAffected(x: x, y: y) {
                    // If the opposite corner is also affected, we found it
                    if isAffected(x: x+99, y: y-99) {
                        let point = Point(x: x, y: y-99)
                        return (point.x * 10_000) + point.y
                    } else {
                        // there is some 'jittering' per line, therefor start
                        // the next line 1 position early to be safe
                        startAt = x-1
                        y += 1
                        continue row
                    }
                }
            }
            // optimization: if we reach this then we didn't find any affected
            // on this row. We can than safely skip 100 rows
            y += 100
        }
        return -1
    }
}
