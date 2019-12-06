//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 06/11/2019.
//

import Foundation
import AdventKit

public class Puzzle {

    let map: [String: String]
    public init(input: String) {

        self.map = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { $0.components(separatedBy: CharacterSet(charactersIn: ")")) }
            .reduce(into: [String:String](), { (dict, line) in
                dict[line[1]] = line[0]
            })
    }

    public func part1() -> Int {
        map
            .lazy
            .map { self.distance(from: $0.key, to: "COM")}
            .reduce(0, +)
    }

    func distance(from: String, to: String) -> Int {
        var count = 1
        var object = map[from]!
        while object != to {
            object = map[object]!
            count += 1
        }
        return count
    }

    public func part2() -> String {
        ""
    }
}
