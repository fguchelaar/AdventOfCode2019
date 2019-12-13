//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 30/11/2019.
//

import Foundation
import AdventKit

extension Int {
    static let empty = 0
    static let wall = 1
    static let block = 2
    static let paddle = 3
    static let ball = 4
}

public class Puzzle {

    let program: [Int]
    public init(input: String) {
        program = input.array(separatedBy: CharacterSet(charactersIn: ","), using: Int.init)
    }

    public func part1() -> Int {
        let ic = IntCode(memory: program)
        ic.runProgram(inputs: [Int]())

        // get all typeId's and count only balls
        return stride(from: 2, to: ic.output.count, by: 3)
            .map { idx in ic.output[idx] }
            .filter { $0 == .block }
            .count
    }

    public func part2() -> Int {
        var playForFree = program
        playForFree[0] = 2

        var outputIndex = 0
        var input = [Int]()
        var board = [Point: Int]()
        let ic = IntCode(memory: playForFree)

        while (true) {
            ic.runProgram(inputs: input)

            // take the last outputs, in sets of 3
            stride(from: outputIndex, to: ic.output.count, by: 3).forEach() {
                board[Point(x: ic.output[$0], y: ic.output[$0+1])] = ic.output[$0+2]
            }

            // set the 'read-pointer' to the back of the array
            outputIndex = ic.output.count

            // uncomment to draw the game to the console
            // draw(board: board)

            if ic.finished {
                return board[Point(x:-1, y: 0)]!
            } else {
                // determine if we should go left or right
                if paddle(board: board).x < ball(board: board).x {
                    input = [1]
                } else if paddle(board: board).x > ball(board: board).x {
                    input = [-1]
                } else {
                    input = [0]
                }
            }
        }
    }

    func paddle(board: [Point: Int]) -> Point {
        board.filter { $0.value == 3 }.first!.key
    }

    func ball(board: [Point: Int]) -> Point {
        board.filter { $0.value == 4 }.first!.key
    }

    func draw(board: [Point: Int]) {

        let minPoint = board.reduce(Point(x: Int.max, y: Int.max)) { Point(x: min($0.x, $1.key.x), y: min($0.y, $1.key.y))}
        let maxPoint = board.reduce(Point(x: Int.min, y: Int.min)) { Point(x: max($0.x, $1.key.x), y: max($0.y, $1.key.y))}

        var output = ""
        for y in (minPoint.y...maxPoint.y) {
            for x in (minPoint.x...maxPoint.x) {
                let type = board[Point(x: x, y: y)] ?? -1
                switch type {
                case .empty:
                    output += " "
                case .wall:
                    output += "#"
                case .block:
                    output += "^"
                case .paddle:
                    output += "-"
                case .ball:
                    output += "o"
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
