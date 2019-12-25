//
//  File.swift
//  
//
//  Created by Frank Guchelaar on 09/12/2019.
//

import Foundation

class IntCode {

    class Memory {
        var _memory: [Int: Int]

        init(memory: [Int]) {
            _memory = memory.enumerated().reduce(into: [Int: Int]()) {
                $0[$1.offset] = $1.element
            }
        }

        func get(_ address: Int) -> Int {
            _memory[address, default: 0]
        }

        func set(_ address: Int, value: Int) {
            _memory[address] = value
        }
    }

    var memory: Memory
    var output = [Int]()
    var instructionPointer = 0
    var relativeBase = 0
    var finished = false

    init(memory: [Int]) {
        self.memory = Memory(memory: memory)
    }

    func runProgram(inputs: [Int]) {
        var inp = inputs
        while(true) {

            let opcode = memory.get(instructionPointer)

            // Set the pointer after the opcode
            instructionPointer +=  1

            var params: [Int]
            switch opcode % 100 {
            case 1: // add
                params = parameters(count: 3, at: instructionPointer, opcode: opcode, lastIsTarget: true)
                memory.set(params[2], value: params[0] + params[1])
                instructionPointer += 3
            case 2: // multiply
                params = parameters(count: 3, at: instructionPointer, opcode: opcode, lastIsTarget: true)
                memory.set(params[2], value: params[0] * params[1])
                instructionPointer += 3
            case 3: // set input
                if inp.isEmpty {
                    instructionPointer -= 1
                    return
                }
                params = parameters(count: 1, at: instructionPointer, opcode: opcode, lastIsTarget: true)
                memory.set(params[0], value: inp.removeFirst())
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
                params = parameters(count: 3, at: instructionPointer, opcode: opcode, lastIsTarget: true)
                memory.set(params[2], value: params[0] < params[1] ? 1 : 0)
                instructionPointer += 3
            case 8: // equals
                params = parameters(count: 3, at: instructionPointer, opcode: opcode, lastIsTarget: true)
                memory.set(params[2], value: params[0] == params[1] ? 1 : 0)
                instructionPointer += 3
            case 9: // adjust relative base
                params = parameters(count: 1, at: instructionPointer, opcode: opcode)
                relativeBase += params[0]
                instructionPointer += 1
            case 99: // halt
                finished = true
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
    ///   - lastIsTarget: when true, the last parameter is never treated as *immediate*
    func parameters(count: Int, at: Int, opcode: Int, lastIsTarget: Bool = false) -> [Int] {
        (at..<(at+count))
            .enumerated()
            .map { (index, element) in
                let value = memory.get(element)
                let power = index + 2
                let div = (pow(10, power) as NSDecimalNumber).intValue

                switch ((opcode / div) % 10 ) {
                case 0:
                    return lastIsTarget && index == count-1 ? value : memory.get(value)
                case 1:
                    return value
                case 2:
                    return lastIsTarget && index == count-1 ? relativeBase + value : memory.get(relativeBase + value)
                default:
                    fatalError()
                }
        }
    }
}
