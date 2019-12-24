//
//  File.swift
//  
//
//  Created by Frank Guchelaar on 24/12/2019.
//

import Foundation
import AdventKit

class Eris {
    
    private (set) var bugs = Set<Point>()

    func countAdjacent(for point: Point) -> Int {
        [point.up, point.down, point.left, point.right]
            .filter { bugs.contains($0) }
            .count
    }

    var rating: Int {
        bugs.reduce(0) {
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
                        bugs.insert(Point(x: character.offset, y: line.offset))
                    }
                }
        }
    }
    
    func step() {
        var tempBugs = Set<Point>()

        for y in 0..<5 {
            for x in 0..<5 {
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
        bugs = tempBugs
    }
}
