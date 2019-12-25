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
        program = input.array(separatedBy: CharacterSet(charactersIn: ","), using: Int.init)
    }

    public func part1() {

        run(instructions: [
            "south",
            "take astronaut ice cream",
            "north",
            "east",
            "take mouse",
            "north",
            "north",
            "east",
            "take sand",
            "west",
            "south",
            "south",
            "south",
            "west",
            "take boulder",
            "south",
            "south",
            "south",
            "west",
            "south",
            "south",
        ], printOutput: true)
    }

    func run(instructions: [String], printOutput: Bool = false) {

        let input = instructions
            .flatMap { "\($0)\n" }
            .map { Int($0.asciiValue!) }

        let ic = IntCode(memory: program)
        ic.runProgram(inputs: input)

        if printOutput {
            let map = String(ic.output.dropLast().map {
                Character(UnicodeScalar($0)!)
            })
            print(map)
        }
    }
}
