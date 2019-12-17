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
//        print(map)

        let grid = map
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .enumerated()
            .reduce(into: [Point: Character]()) { (g, l) in
                l.element.enumerated()
                    .filter { c in c.element != "." }
                    .forEach { c in g[Point(x: c.offset, y: l.offset)] = c.element }
        }
//        draw(board: grid)

        let intersections = grid
            .map { $0.key }
            .filter { grid[$0.up] != nil && grid[$0.down] != nil && grid[$0.left] != nil && grid[$0.right] != nil }

        return intersections.reduce(0) {
            $0 + ($1.x * $1.y)
        }
    }

    public func part2() -> String {
        ""
    }

    func draw(board: [Point: Character]) {

        let minPoint = board.reduce(Point(x: Int.max, y: Int.max)) { Point(x: min($0.x, $1.key.x), y: min($0.y, $1.key.y))}
        let maxPoint = board.reduce(Point(x: Int.min, y: Int.min)) { Point(x: max($0.x, $1.key.x), y: max($0.y, $1.key.y))}

        var output = ""
        for y in (minPoint.y...maxPoint.y) {
            for x in (minPoint.x...maxPoint.x) {
                if let char = board[Point(x: x, y: y)] {
                    output += String(char)
                } else {
                    output += "."
                }
            }
            output += "\n"
        }
        print(output)
    }
}
