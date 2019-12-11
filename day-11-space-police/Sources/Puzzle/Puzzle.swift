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
        program = input
            .array(separatedBy: CharacterSet(charactersIn: ","),
                   using: Int.init)
    }

    public func part1() -> Int {
        let solver = Solver(program: program)
        solver.solve(baseColor: 0)
        return Set<Point>(solver.path).count
    }

    public func part2() -> String {
        let solver = Solver(program: program)
        solver.solve(baseColor: 1)

        // find the boundaries of the panel-grid
        let path = solver.path
        let minPoint = path.reduce(Point(x: Int.max, y: Int.max)) { Point(x: min($0.x, $1.x), y: min($0.y, $1.y)) }
        let maxPoint = path.reduce(Point(x: Int.min, y: Int.min)) { Point(x: max($0.x, $1.x), y: max($0.y, $1.y)) }

        // construct an text-represenation of the panels
        var code = "\n"
        for y in (minPoint.y...maxPoint.y) {
            for x in (minPoint.x...maxPoint.x) {
                code += solver.panels[(Point(x: x, y: y))] == 1 ? "#" : " "
            }
            code += "\n"
        }
        return code
    }
}
