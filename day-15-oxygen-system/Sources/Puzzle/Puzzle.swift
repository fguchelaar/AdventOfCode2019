//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 30/11/2019.
//

import Foundation
import AdventKit

extension Int {
    static let wall = 0
    static let empty = 1
    static let oxygen = 2
}

public class Puzzle {

    let program: [Int]
    public init(input: String) {
        program = input.array(separatedBy: CharacterSet(charactersIn: ","), using: Int.init)
    }

    typealias tuple = (command: [Int], vector: Point, iCommand: [Int], iVector: Point)
    let north: tuple = ([1], Point(x: 0, y: -1), [2], Point(x: 0, y: 1))
    let south: tuple = ([2], Point(x: 0, y: 1), [1], Point(x: 0, y: -1))
    let west: tuple = ([3], Point(x: -1, y: 0), [4], Point(x: 1, y: 0))
    let east: tuple = ([4], Point(x: 1, y: 0), [3], Point(x: -1, y: 0))

    func candidates(for position: Point, on board: [Point: Int]) -> [tuple] {
        [
            board[position + north.vector] == nil ? north : nil,
            board[position + south.vector] == nil ? south : nil,
            board[position + west.vector] == nil ? west : nil,
            board[position + east.vector] == nil ? east : nil,
            ]
            .compactMap { $0 }
    }


    public func part1() -> Int {
        var board = [Point: Int]()
        var position = Point(x: 0, y: 0)
        board[position] = .empty

        var returnPath = [tuple]()

        let ic = IntCode(memory: program)
        ic.runProgram(inputs: [])

        while board[position] != .oxygen {

            if let candidate = candidates(for: position, on: board).first {
                ic.runProgram(inputs: candidate.command)
                board[position + candidate.vector] = ic.output.last!
                if board[position + candidate.vector] != .wall {
                    position = position + candidate.vector
                    returnPath.append(candidate)
                }
            } else {
                let direction = returnPath.removeLast()
                ic.runProgram(inputs: direction.iCommand)
                position = position + direction.iVector
            }
        }
        return returnPath.count
    }

    public func part2() -> Int {
        var board = [Point: Int]()
        var position = Point(x: 0, y: 0)
        board[position] = .empty

        var returnPath = [tuple]()

        let ic = IntCode(memory: program)
        ic.runProgram(inputs: [])

        // keep on walking until we're back at the starting position with no
        // further options
        while position != Point(x: 0, y: 0) || !candidates(for: Point(x: 0, y: 0), on: board).isEmpty {

            if let candidate = candidates(for: position, on: board).first {
                ic.runProgram(inputs: candidate.command)
                board[position + candidate.vector] = ic.output.last!
                if board[position + candidate.vector] != .wall {
                    position = position + candidate.vector
                    returnPath.append(candidate)
                }
            } else {
                let direction = returnPath.removeLast()
                ic.runProgram(inputs: direction.iCommand)
                position = position + direction.iVector
            }
        }
        draw(board: board, position: position)

        let oxygen = board.first { $0.value == .oxygen }!.key

        var points = [oxygen]
        var minutes = 0
        while !(board.filter { $0.value == .empty }).isEmpty {

            let next = points.flatMap { point in
                [
                    point + north.vector,
                    point + south.vector,
                    point + west.vector,
                    point + east.vector,
                ]
            }
            .filter { board[$0] == .empty }

            next.forEach { point in
                board[point] = .oxygen
            }
            points = next
            minutes += 1
        }

        return minutes
    }

    func draw(board: [Point: Int], position: Point) {

        let minPoint = board.reduce(Point(x: Int.max, y: Int.max)) { Point(x: min($0.x, $1.key.x), y: min($0.y, $1.key.y))}
        let maxPoint = board.reduce(Point(x: Int.min, y: Int.min)) { Point(x: max($0.x, $1.key.x), y: max($0.y, $1.key.y))}

        var output = ""
        for y in (minPoint.y...maxPoint.y) {
            for x in (minPoint.x...maxPoint.x) {
                if Point(x: x, y: y) == position {
                    output += "X"
                    continue
                }
                let type = board[Point(x: x, y: y)] ?? -1
                switch type {
                case .empty:
                    output += " "
                case .wall:
                    output += "#"
                case .oxygen:
                    output += "O"
                default:
                    output += " "
                }
            }
            output += "\n"
        }

        print("\u{001B}[2J")
        print(output)
    }
}
