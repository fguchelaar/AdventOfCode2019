//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 10/12/2019.
//

import Foundation
import AdventKit

public class Puzzle {

    let asteroids: Set<Point>
    public init(input: String) {
        asteroids = Set(input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .enumerated()
            .flatMap {(y, row) in
                row.enumerated()
                    .filter { (x, col) in String(col) == "#"}
                    .map { (x, col) in Point(x: x, y: y)}
        })
    }

    public func part1() -> Int {
        return createAngleMap().map { $0.value.count }.max()!
    }

    /// creates a dictinonary containing all visible angles for each position
    func createAngleMap() -> [Point: Set<Double>] {
        // store the angles of visible asteroids in a set per asteroid
        asteroids.reduce(into: [Point: Set<Double>]()) { (dict, point) in
            let others = asteroids.filter { $0 != point }
            let angleSet = others.reduce(into: Set<Double>()) { (set, otherPoint) in
                set.insert(point.angle(to: otherPoint))
            }
            dict[point] = angleSet
        }
    }

    public func part2() -> Int {
        // First use the angleMap from part 1 to get the monitoring station location
        let station = createAngleMap().max {
            $0.value.count < $1.value.count
        }!.key

        var vaporizeList = [Point]()
        while(vaporizeList.count < 200) {
            let remaining = asteroids.filter { !vaporizeList.contains($0) }
            let visibleAsteroids = visible(in: remaining, for: station)
            vaporizeList.append(contentsOf: visibleAsteroids)
        }

        let number200 = vaporizeList[199]
        return number200.x*100 + number200.y
    }

    /// returns a list of points (in angle-order) that are visible to the given point
    func visible(in asteroidField: Set<Point>, for point: Point) -> [Point] {
        let angles = asteroidField.reduce(into: [Double: Point]()) { (dict, asteroid) in
            let angle = point.angle(to: asteroid)
            let current = dict[angle]
            if current == nil || point.manhattan(to: current!) > point.manhattan(to: asteroid) {
                dict[angle] = asteroid
            }
        }
        return angles.sorted { $0.key < $1.key }.map { $0.value }
    }
}
