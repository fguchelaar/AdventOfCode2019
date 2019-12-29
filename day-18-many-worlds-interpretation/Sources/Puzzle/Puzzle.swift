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

    func astar(grid: [Point: Tile], from: Point, to: Point) -> [Point]? {

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
        return -1
    }

    public func part2() -> Int {
        -1
    }
}
