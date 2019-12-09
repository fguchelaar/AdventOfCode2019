//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 09/12/2019.
//

import Foundation
import AdventKit

public class Puzzle {

    let memory: [Int]
    public init(input: String) {
        memory = input.array(separatedBy: CharacterSet(charactersIn: ","), using: Int.init)
    }

    public func part1() -> Int {
        let ic = IntCode(memory: memory)
        ic.runProgram(inputs: [1])
        return ic.output.last!
    }

    public func part2() -> Int {
        let ic = IntCode(memory: memory)
        ic.runProgram(inputs: [2])
        return ic.output.last!
    }
}
