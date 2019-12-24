//
//  File.swift
//  
//
//  Created by Frank Guchelaar on 24/12/2019.
//

import Foundation
import AdventKit

class Bugs {

    let top = [Point(x: 0, y: 0),
               Point(x: 1, y: 0),
               Point(x: 2, y: 0),
               Point(x: 3, y: 0),
               Point(x: 4, y: 0)]
    let bottom = [Point(x: 0, y: 4),
                  Point(x: 1, y: 4),
                  Point(x: 2, y: 4),
                  Point(x: 3, y: 4),
                  Point(x: 4, y: 4)]
    let left = [Point(x: 0, y: 0),
                Point(x: 0, y: 1),
                Point(x: 0, y: 2),
                Point(x: 0, y: 3),
                Point(x: 0, y: 4)]
    let right = [Point(x: 4, y: 0),
                 Point(x: 4, y: 1),
                 Point(x: 4, y: 2),
                 Point(x: 4, y: 3),
                 Point(x: 4, y: 4)]
    let center = [Point(x: 2, y: 1),
                  Point(x: 1, y: 2),
                  Point(x: 3, y: 2),
                  Point(x: 2, y: 3)]

    private var bugs = Set<Point>()
    private var tempBugs = Set<Point>()

    var up: Bugs?
    var down: Bugs?

    var count: Int {
        bugs.count
    }

    var countUp: Int {
        (up?.count ?? 0) + (up?.countUp ?? 0)
    }

    var countDown: Int {
        (down?.count ?? 0) + (down?.countDown ?? 0)
    }

    func add(bug: Point) {
        bugs.insert(bug)
    }

    func contains(bug: Point) -> Bool {
        bugs.contains(bug)
    }

    func countBugs(at points: [Point]) -> Int {
        points.filter { bugs.contains($0) }.count
    }

    func countAdjacent(for point: Point) -> Int {
        if center.contains(point) {
            if point == Point(x: 2, y: 1) {
                return (down?.countBugs(at: top) ?? 0)
                    + countBugs(at: [point.up, point.left, point.right])
            }
            if point == Point(x: 2, y: 3) {
                return (down?.countBugs(at: bottom) ?? 0)
                    + countBugs(at: [point.down, point.left, point.right])
            }
            if point == Point(x: 1, y: 2) {
                return (down?.countBugs(at: left) ?? 0)
                    + countBugs(at: [point.up, point.down, point.left])
            }
            if point == Point(x: 3, y: 2) {
                return (down?.countBugs(at: right) ?? 0)
                    + countBugs(at: [point.up, point.down, point.right])
            }
        } else {
            var cnt = 0
            if let up = up {
                if point.x == 0 {
                    cnt += up.countBugs(at: [Point(x: 1, y: 2)])
                }
                if point.x == 4 {
                    cnt += up.countBugs(at: [Point(x: 3, y: 2)])
                }
                if point.y == 0 {
                    cnt += up.countBugs(at: [Point(x: 2, y: 1)])
                }
                if point.y == 4 {
                    cnt += up.countBugs(at: [Point(x: 2, y: 3)])
                }
            }
            return cnt + countBugs(at: [point.up, point.down, point.left, point.right])
        }
        fatalError()
    }

    func step() {
        step(0)
    }

    /// Execute a step, the `level` is used to indicate if the stepping should be passed on
    /// upward (negative level) or downward (positive level)
    private func step(_ level: Int) {

        if up == nil && countBugs(at: top + bottom + left + right) > 0 {
            up = Bugs()
            up?.down = self
        }

        if down == nil && countBugs(at: center) > 0 {
            down = Bugs()
            down?.up = self
        }

        tempBugs.removeAll()

        for y in 0..<5 {
            for x in 0..<5 {
                if x == 2 && y == 2 {
                    continue
                }
                let point = Point(x: x, y: y)
                let adjacent = countAdjacent(for: point)

                if bugs.contains(point) {
                    if adjacent == 1 {
                        tempBugs.insert(point)
                    }
                } else if adjacent == 1 || adjacent == 2 {
                    tempBugs.insert(point)
                }
            }
        }

        if level < 0 {
            up?.step(level - 1)
        }
        if level > 0 {
            down?.step(level + 1)
        }

        // if the level we're on is 0, then we're at the root. Initiate steps
        // both ways
        if level == 0 {
            up?.step(-1)
            down?.step(1)
        }

        bugs = tempBugs
    }
}
