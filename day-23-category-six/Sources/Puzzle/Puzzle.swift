//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 30/11/2019.
//

import Foundation
import AdventKit

class Wrapper {

    let ic: IntCode
    var inputs: Queue<Int>
    var target: Int?
    var outputPointer: Int

    init(program: [Int], nic: Int) {
        ic = IntCode(memory: program)
        inputs = Queue<Int>()
        inputs.enqueue(nic)
        target = nil
        outputPointer = 0
    }
}

public class Puzzle {

    let program: [Int]
    public init(input: String) {
        program = input.array(separatedBy: CharacterSet(charactersIn: ","), using: Int.init)
    }

    public func part1() -> Int {

        let ics: [Wrapper] =
            (0..<50).map { i in
                Wrapper(program: program, nic: i)
        }

        while true {
            for wrapper in ics {
                if let input = wrapper.inputs.dequeue() {
                    wrapper.ic.runProgram(inputs: [input])
                } else {
                    wrapper.ic.runProgram(inputs: [-1])
                }
                if wrapper.ic.output.count > wrapper.outputPointer {
                    let outputs = wrapper.ic.output[wrapper.outputPointer...]
                    for output in outputs.enumerated() {
                        if output.offset % 3 == 0 {
                            wrapper.target = output.element
                        } else if wrapper.target == 255 {
                            if output.offset % 3 == 2 {
                                return output.element
                            }
                        }
                        else {
                            ics[wrapper.target!].inputs.enqueue(output.element)
                        }

                    }
                    wrapper.outputPointer = wrapper.ic.output.count
                }
            }
        }
    }

    public func part2() -> String {
        ""
    }
}
