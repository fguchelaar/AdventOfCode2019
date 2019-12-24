//
//  File.swift
//  
//
//  Created by Frank Guchelaar on 24/12/2019.
//

import Foundation
import AdventKit

extension Point {
    var up: Point { Point(x: x, y: self.y-1) }
    var down: Point { Point(x: x, y: self.y+1) }
    var left: Point { Point(x: x-1, y: self.y) }
    var right: Point { Point(x: x+1, y: self.y) }
}

class Eris {
    
    private class Bugs {
        private (set) var bugs = Set<Point>()
        
        func add(bug: Point) {
            bugs.insert(bug)
        }
        
        func removet(bug: Point) {
            bugs.remove(bug)
        }
        
        func contains(bug: Point) -> Bool {
            bugs.contains(bug)
        }
        
        func removeAll() {
            bugs.removeAll()
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
                let adjacent = [point.up, point.down, point.left, point.right]
                    .filter { activeBugs.contains(bug: $0)
                }.count
                
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
