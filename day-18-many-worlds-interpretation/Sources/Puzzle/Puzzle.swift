//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 30/11/2019.
//

import Foundation
import AdventKit

enum Tile {
    case wall
    case open
    case key(letter: String.Element)
    case door(letter: String.Element)
    case entrance
}

extension Point {
    var up: Point { Point(x: x, y: y-1) }
    var down: Point { Point(x: x, y: y+1) }
    var left: Point { Point(x: x-1, y: y) }
    var right: Point { Point(x: x+1, y: y) }
}

extension Point: CustomStringConvertible {
    public var description: String {
        "(\(x),\(y))"
    }
}

public class Puzzle {

    var maze: [Point: Tile]
    var keys: [Point: String.Element]
    var doors: [Point: String.Element]
    var entrance: Point

    public init(input: String) {
        maze = [:]
        keys = [:]
        doors = [:]
        entrance = .zero

        input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .enumerated().forEach { (y, line) in
                line
                    .enumerated().forEach { (x, character) in
                        let point = Point(x: x, y: y)
                        if character == "#" {
                            maze[point] = .wall
                        }
                        else if character == "." {
                            maze[point] = .open
                        }
                        else if character == "@" {
                            maze[point] = .entrance
                            entrance = point
                        }
                        else if character.isUppercase {
                            maze[point] = .door(letter: character)
                            doors[point] = character
                        }
                        else if character.isLowercase {
                            maze[point] = .key(letter: character)
                            keys[point] = character
                        }
                }
        }
    }

    func astar(grid: [Point: Tile], start: Point, goal: Point, neighbors: (Point) -> [Point]) -> [Point]? {

        func reconstruct(_ map: [Point: Point], _ point: Point) -> [Point] {
            var current = point
            var totalPath = [current]
            while map.keys.contains(current) {
                current = map[current]!
                totalPath.insert(current, at: 0)
            }
            return totalPath
        }

        func h(_ point: Point) -> Int {
            point.manhattan(to: goal)
        }

        var openSet = Set<Point>()
        var cameFrom = [Point: Point]()
        var gScore = [Point: Int]()
        var fScore = [Point: Int]()

        openSet.insert(start)
        gScore[start] = 0
        fScore[goal] = h(start)

        var current: Point
        while !openSet.isEmpty {
            current = openSet.sorted { fScore[$0, default: Int.max] < fScore[$1, default: Int.max] }.first!
            if current == goal {
                return reconstruct(cameFrom, current)
            }

            openSet.remove(current)
            for neighbor in neighbors(current) {
                let tentativeScore = gScore[current, default: Int.max] + 1
                if tentativeScore < gScore[neighbor, default: Int.max] {
                    cameFrom[neighbor] = current
                    gScore[neighbor] = tentativeScore
                    fScore[neighbor] = gScore[neighbor, default: Int.max] + h(neighbor)
                    if !openSet.contains(neighbor) {
                        openSet.insert(neighbor)
                    }
                }
            }

        }
        return nil
    }

    func draw(grid: [Point: Tile]) {
        var output = ""
        let maxPoint = grid.reduce(Point.min) { Point(x: max($0.x, $1.key.x), y: max($0.y, $1.key.y)) }
        for y in 0...maxPoint.y {
            for x in 0...maxPoint.x {
                switch grid[Point(x: x, y: y)] {
                case .wall:
                    output.append("#")
                case .open:
                    output.append(".")
                case .entrance:
                    output.append("@")
                case .door(let door):
                    output.append(door)
                case .key(let key):
                    output.append(key)
                default:
                    output.append(" ")
                }
            }
            output.append("\n")
        }
        print(output)
    }

    public func part1() -> Int {
        draw(grid: maze)

        let neighbors: (Point) -> [Point] = { point in

            // If we're standing on a key, only proceed if we have that key in
            // our possesion. This way we can minimize visible paths to the
            // 'direct' keys
            if self.keys.keys.contains(point) {
                return []
            }

            return [point.up, point.down, point.left, point.right].filter { p in
                switch self.maze[p] {
                case .open, .key:
                    return true
                case .door(let door):
                    return false
                default:
                    return false
                }
            }
        }

        // Route to all keys
        keys.sorted { $0.value < $1.value }.forEach {
            if let route = astar(grid: maze, start: entrance, goal: $0.key, neighbors: neighbors) {
                print ("\($0.value): \(route)")
            } else {
                print ("\($0.value): no route")
            }
        }

        return -1
    }

    public func part2() -> Int {
        -1
    }
}
