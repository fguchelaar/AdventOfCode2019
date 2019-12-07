//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 07/11/2019.
//

import Foundation
import AdventKit

public class Puzzle {

    let software: [Int]
    public init(input: String) {
        self.software = input.array(separatedBy: CharacterSet(charactersIn: ","),
                                    using: Int.init)
    }

    public func part1() -> Int {
        let permutations = [0,1,2,3,4].permutations()
        var maxOutput = Int.min
        for permutation in permutations {
            var input = 0
            var lastOutput = Int.min
            for phase in permutation {
                let ic = IntCode(memory: software)
                ic.runProgram(inputs: [phase, input])
                lastOutput = ic.output.last!
                input = lastOutput
            }
            maxOutput = max(maxOutput, lastOutput)
        }
        return maxOutput
    }

    public func part2() -> Int {
        let permutations = [5,6,7,8,9].permutations()
        var maxOutput = Int.min
        for permutation in permutations {

            let a = IntCode(memory: software)
            let b = IntCode(memory: software)
            let c = IntCode(memory: software)
            let d = IntCode(memory: software)
            let e = IntCode(memory: software)

            var firstRun = true

            while !e.finished {
                a.runProgram(inputs: firstRun ? [permutation[0], 0]: [e.output.last!])
                b.runProgram(inputs: firstRun ? [permutation[1], a.output.last!]: [a.output.last!])
                c.runProgram(inputs: firstRun ? [permutation[2], b.output.last!]: [b.output.last!])
                d.runProgram(inputs: firstRun ? [permutation[3], c.output.last!]: [c.output.last!])
                e.runProgram(inputs: firstRun ? [permutation[4], d.output.last!]: [d.output.last!])
                firstRun = false
            }
            maxOutput = max(maxOutput, e.output.last!)
        }
        return maxOutput
    }
}
