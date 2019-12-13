//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 12/12/2019.
//

import Foundation
import AdventKit

public class Puzzle {

    let coordinates: [[Int]]
    public init(input: String) {
        self.coordinates = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { $0.extractInts() }
    }

    public func part1(steps: Int = 1000) -> Int {
        let moons = coordinates.map {
            Moon(x: $0[0], y: $0[1], z: $0[2])
        }

        (0..<steps).forEach { _ in
            moons.forEach { moon in 
                moon.applyGravity(from: moons)
            }

            moons.forEach { moon in 
                moon.move()
            }
        }

        return moons.reduce(0) {
            $0 + $1.total
        }
    }

    public func part2() -> Int {
        let moons = coordinates.map {
            Moon(x: $0[0], y: $0[1], z: $0[2])
        }

        var foundX = false
        var foundY = false
        var foundZ = false

        var foundAt = [Int]()
        var steps = 0

        while true {

            moons.forEach { moon in
                moon.applyGravity(from: moons)
            }

            moons.forEach { moon in
                moon.move()
            }
            steps += 1

            if !foundX {
                if (moons.allSatisfy { $0.isAtStartX }) {
                    foundX = true
                    foundAt.append(steps)
                }
            }
            if !foundY {
                if (moons.allSatisfy { $0.isAtStartY }) {
                    foundY = true
                    foundAt.append(steps)
                }
            }
            if !foundZ {
                if (moons.allSatisfy { $0.isAtStartZ }) {
                    foundZ = true
                    foundAt.append(steps)
                }
            }

            if (foundX && foundY && foundZ) {
                break
            }
        }
        return lcm(foundAt)
    }
}
