//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 03/12/2019.
//

import Foundation
import AdventKit

public class Puzzle {

    typealias instruction = (direction: String, steps: Int)

    let wires: [[Point]]

    public init(input: String) {
        self.wires = input
            .array(separatedBy: .newlines, using: Puzzle.parse(line:))
            .map(Puzzle.parse(instructions:))
    }

    class func parse(line: String) -> [instruction] {
        line.split(separator: ",").map {
            instruction(String($0.first!), Int($0.dropFirst())!)
        }
    }

    class func parse(instructions: [instruction]) -> [Point] {
        var position = Point(x: 0, y: 0)
        var positions = [position]
        for instruction in instructions {
            let vector: Point = {
                switch instruction.direction {
                case "U": return Point(x: 0, y: 1)
                case "R": return Point(x: 1, y: 0)
                case "D": return Point(x: 0, y: -1)
                case "L": return Point(x: -1, y: 0)
                default: fatalError()
                }
            }()
            for _ in 0..<instruction.steps {
                position = position + vector
                positions.append(position)
            }
        }

        return positions
    }

    public func part1() -> Int {
        // only two wires, so we can shorthand it
        let set1 = Set<Point>(wires[0])
        let set2 = Set<Point>(wires[1])

        return set1.intersection(set2)
            .map { $0.manhattan(to: Point(x: 0, y: 0))}
            .filter { $0 != 0}
            .sorted()
            .first!
    }

    public func part2() -> Int {
        // only two wires, so we can shorthand it
        let set1 = Set<Point>(wires[0])
        let set2 = Set<Point>(wires[1])

        return set1.intersection(set2)
            .map { wires[0].firstIndex(of: $0)! + wires[1].firstIndex(of: $0)! }
            .filter { $0 != 0 }
            .sorted()
            .first!
    }
}
