//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 30/11/2019.
//

import Foundation
import AdventKit

extension Point {
    var up: Point { Point(x: self.x, y: self.y - 1)}
    var down: Point { Point(x: self.x, y: self.y + 1)}
    var left: Point { Point(x: self.x - 1, y: self.y)}
    var right: Point { Point(x: self.x + 1, y: self.y)}
}

public class Puzzle {

    let program: [Int]
    public init(input: String) {
        program = input.array(separatedBy: CharacterSet(charactersIn: ","), using: Int.init)
    }

    public func part1() -> Int {
        let ic = IntCode(memory: program)
        ic.runProgram(inputs: [])

        let map = String(ic.output.map {
            Character(UnicodeScalar($0)!)
        })
        // print(map)

        let grid = map
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .enumerated()
            .reduce(into: [Point: Character]()) { (g, l) in
                l.element.enumerated()
                    .filter { c in c.element != "." }
                    .forEach { c in g[Point(x: c.offset, y: l.offset)] = c.element }
        }

        let intersections = grid
            .map { $0.key }
            .filter { grid[$0.up] != nil && grid[$0.down] != nil && grid[$0.left] != nil && grid[$0.right] != nil }

        return intersections.reduce(0) {
            $0 + ($1.x * $1.y)
        }
    }

    public func part2() -> Int {
        let routine = "A,A,B,C,B,C,B,C,B,A\n".map { $0.asciiValue! }
        let functionA = "L,10,L,8,R,8,L,8,R,6\n".map { $0.asciiValue! }
        let functionB = "R,6,R,8,R,8\n".map { $0.asciiValue! }
        let functionC = "R,6,R,6,L,8,L,10\n".map { $0.asciiValue! }
        let feedback = "n\n".map { $0.asciiValue! }

        let input =  [
            routine,
            functionA,
            functionB,
            functionC,
            feedback
            ]
            .flatMap { $0 }
            .map { Int($0) }

        var altered = program
        altered[0] = 2
        let ic = IntCode(memory: altered)
        ic.runProgram(inputs: input)

        return ic.output.last!
    }
}
