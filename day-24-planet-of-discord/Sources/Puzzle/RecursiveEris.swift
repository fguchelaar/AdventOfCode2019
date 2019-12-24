//
//  File.swift
//
//
//  Created by Frank Guchelaar on 24/12/2019.
//

import Foundation
import AdventKit

class RecursiveEris {

    private class Bugs {
        private (set) var bugs = Set<Point>()

        func add(bug: Point) {
            bugs.insert(bug)
        }

        func contains(bug: Point) -> Bool {
            bugs.contains(bug)
        }

        func removeAll() {
            bugs.removeAll()
        }

        func adjacent(for point: Point) -> Int {
            [point.up, point.down, point.left, point.right]
                .filter { bugs.contains($0)
            }.count
        }
    }

    private var bugsA = Bugs()
    private var bugsB = Bugs()
    private var toggled = false

    private var activeBugs: Bugs {
        toggled ? bugsB : bugsA
    }

    private var tempBugs: Bugs {
        toggled ? bugsA : bugsB
    }

    var rating: Int {
        activeBugs.bugs.reduce(0) {
            $0 + Int(truncating: NSDecimalNumber(decimal: pow(2, ($1.y * 5) + $1.x)))
        }
    }

    init(map: String) {
        map
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .enumerated()
            .forEach { line in
                line.element.enumerated().forEach { character in
                    if character.element == "#" {
                        activeBugs.add(bug: Point(x: character.offset, y: line.offset))
                    }
                }
        }
    }

    func step() {
        tempBugs.removeAll()
        for y in 0..<5 {
            for x in 0..<5 {
                let point = Point(x: x, y: y)
                let adjacent = activeBugs.adjacent(for: point)

                if activeBugs.contains(bug: point) {
                    if adjacent == 1 {
                        tempBugs.add(bug: point)
                    }
                } else {
                    if adjacent == 1 || adjacent == 2 {
                        tempBugs.add(bug: point)
                    }
                }
            }
        }
        toggled.toggle()
    }
}
