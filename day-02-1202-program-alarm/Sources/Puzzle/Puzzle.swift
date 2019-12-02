//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 2/12/2019.
//

import Foundation
import AdventKit

public class Puzzle {

    let input: [Int]
    public init(input: String) {
        self.input = input.array(separatedBy: CharacterSet(arrayLiteral: ","),
                                 using: Int.init)
    }

    public func part1() -> Int {
        restore(input, noun: 12, verb: 2)[0]
    }

    public func part2() -> Int {
        for noun in 0...99 {
            for verb in 0...99 {
                if restore(input, noun: noun, verb: verb)[0] == 19690720 {
                    return 100 * noun + verb
                }
            }
        }
        fatalError()
    }

    func restore(_ program: [Int], noun: Int, verb: Int) -> [Int] {
        var program = program
        program[1] = noun
        program[2] = verb

        var instructionPointer = 0
        while program[instructionPointer] != 99 {
            let opcode = program[instructionPointer]
            let parameter1 = program[instructionPointer+1]
            let parameter2 = program[instructionPointer+2]
            let targetAddress = program[instructionPointer+3]
            if opcode == 1 {
                program[targetAddress] = program[parameter1] + program[parameter2]
            } else if opcode == 2 {
                program[targetAddress] = program[parameter1] * program[parameter2]
            }
            instructionPointer += 4
        }

        return program
    }
}
