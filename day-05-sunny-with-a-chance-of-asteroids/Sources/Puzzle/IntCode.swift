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

            // Set the pointer after the opcodeƒ
            instructionPointer +=  1

            var params: [Int]
            switch opcode % 100 {
            case 1: // add
                params = parameters(count: 2, at: instructionPointer, opcode: opcode)
                memory[memory[instructionPointer+2]] =  params[0] + params[1]
                instructionPointer += 3
            case 2: // multiply
                params = parameters(count: 2, at: instructionPointer, opcode: opcode)
                memory[memory[instructionPointer+2]] =  params[0] * params[1]
                instructionPointer += 3
            case 3: // set input
                memory[memory[instructionPointer]] = input
                instructionPointer += 1
            case 4: // output
                params = parameters(count: 1, at: instructionPointer, opcode: opcode)
                output.append(params[0])
                instructionPointer += 1
            case 5: // jump-if-true
                params = parameters(count: 2, at: instructionPointer, opcode: opcode)
                if params[0] != 0 {
                    instructionPointer = params[1]
                    continue
                }
                instructionPointer += 2
            case 6: // jump-if-false
                params = parameters(count: 2, at: instructionPointer, opcode: opcode)
                if params[0] == 0 {
                    instructionPointer = params[1]
                    continue
                }
                instructionPointer += 2
            case 7: // less than
                params = parameters(count: 2, at: instructionPointer, opcode: opcode)
                memory[memory[instructionPointer+2]] = params[0] < params[1] ? 1 : 0
                instructionPointer += 3
            case 8: // equals
                params = parameters(count: 2, at: instructionPointer, opcode: opcode)
                memory[memory[instructionPointer+2]] = params[0] == params[1] ? 1 : 0
                instructionPointer += 3
            case 99: // halt
                return
            default:
                fatalError()
            }
        }
    }

    /// Maps `count` parameters to either their immediate- or postion-mode value
    /// - Parameters:
    ///   - count: number of params to get
    ///   - at: starting a location
    ///   - opcode: opcode to use for determining the mode
    func parameters(count: Int, at: Int, opcode: Int) -> [Int] {
        Array(memory[at..<(at+count)]).enumerated()
            .map { (index, element) in
                let power = index + 2
                let div = (pow(10, power) as NSDecimalNumber).intValue
                return ((opcode / div) % 10 ) == 1 ? element : memory[element]
        }
    }
}
