//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 05/12/2019.
//

import Foundation
import AdventKit

public class Puzzle {

    let input: [Int]
    public init(input: String) {
        self.input = input.array(separatedBy: CharacterSet(charactersIn: ","),
                                 using: Int.init)
    }

    public func part1() -> Int {
        let ic = IntCode(memory: input, input: 1)
        ic.runProgram()
        return ic.output.last!
    }

    public func part2() -> Int {
        let ic = IntCode(memory: input, input: 5)
        ic.runProgram()
        return ic.output.last!
    }
}
