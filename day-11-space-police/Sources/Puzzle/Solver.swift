//
//  File.swift
//  
//
//  Created by Frank Guchelaar on 11/12/2019.
//

import Foundation
import AdventKit

class Solver {
    /// vectors for movement
    let vectors = [
        Point(x: 0, y: -1),
        Point(x: 1, y: 0),
        Point(x: 0, y: 1),
        Point(x: -1, y: 0)
    ]

    var position: Point
    var path: [Point]
    var panels = [Point: Int]()
    var direction = 0
    let program: [Int]

    init(program: [Int]) {
        self.program = program
        self.position = Point(x: 0, y: 0)
        self.path = [position]
    }

    func solve(baseColor: Int) {
        let ic = IntCode(memory: program)

        while true {
            ic.runProgram(inputs: [panels[position, default: baseColor]])
            if ic.finished { break }

            let output = Array(ic.output.suffix(2))
            let color = output[0]
            let turn = output[1]

            panels[position] = color

            direction += turn == 0 ? -1 : 1
            direction = (direction + 4) % 4
            position = position + vectors[direction]
            path.append(position)
        }
    }
}
