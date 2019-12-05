//
//  File.swift
//  
//
//  Created by Frank Guchelaar on 05/12/2019.
//

import Foundation

class IntCode {
    var memory: [Int]
    let input: Int
    var output = [Int]()
    var instructionPointer = 0

    init(memory: [Int], input: Int) {
        self.memory = memory
        self.input = input
    }

    func runProgram() {

        while(instructionPointer<memory.count) {

            let opcode = memory[instructionPointer]
            // Add an extra 1 to account for the opcode itself
            self.instructionPointer +=  1

            var parameters: [(Bool, Int)]
            switch opcode % 100 {
            case 1:
                parameters = params(count: 3, at: instructionPointer, opcode: opcode)
                memory[parameters[2].1] =
                    (parameters[0].0 ? parameters[0].1 : memory[parameters[0].1]) +
                    (parameters[1].0 ? parameters[1].1 : memory[parameters[1].1])
            case 2:
                parameters = params(count: 3, at: instructionPointer, opcode: opcode)
                memory[parameters[2].1] =
                    (parameters[0].0 ? parameters[0].1 : memory[parameters[0].1]) *
                    (parameters[1].0 ? parameters[1].1 : memory[parameters[1].1])
            case 3:
                parameters = params(count: 1, at: instructionPointer, opcode: opcode)
                memory[parameters[0].1] = input
            case 4:
                parameters = params(count: 1, at: instructionPointer, opcode: opcode)
                output.append(parameters[0].0 ? parameters[0].1 : memory[parameters[0].1])
            case 5:
                parameters = params(count: 2, at: instructionPointer, opcode: opcode)
                if (parameters[0].0 ? parameters[0].1 : memory[parameters[0].1]) != 0 {
                    instructionPointer = (parameters[1].0 ? parameters[1].1 : memory[parameters[1].1])
                    continue
                }
            case 6:
                parameters = params(count: 2, at: instructionPointer, opcode: opcode)
                if (parameters[0].0 ? parameters[0].1 : memory[parameters[0].1]) == 0 {
                    instructionPointer = (parameters[1].0 ? parameters[1].1 : memory[parameters[1].1])
                    continue
                }
            case 7:
                parameters = params(count: 3, at: instructionPointer, opcode: opcode)
                let p1 = (parameters[0].0 ? parameters[0].1 : memory[parameters[0].1])
                let p2 = (parameters[1].0 ? parameters[1].1 : memory[parameters[1].1])
                memory[parameters[2].1] = p1 < p2 ? 1 : 0
            case 8:
                parameters = params(count: 3, at: instructionPointer, opcode: opcode)
                let p1 = (parameters[0].0 ? parameters[0].1 : memory[parameters[0].1])
                let p2 = (parameters[1].0 ? parameters[1].1 : memory[parameters[1].1])
                memory[parameters[2].1] = p1 == p2 ? 1 : 0
            case 99:
                return
            default:
                fatalError()
            }

            self.instructionPointer += parameters.count
        }
    }

    func params(count: Int, at: Int, opcode: Int) -> [(Bool,Int)] {
        Array(memory[at..<(at+count)]).enumerated()
            .map { (index, element) in
                let power = index + 2
                let div = (pow(10, power) as NSDecimalNumber).intValue
                return ((opcode / div) % 10 ) == 1 ? (true, element) : (false, element)
        }
    }
}
