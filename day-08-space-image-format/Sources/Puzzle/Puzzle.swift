//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 30/11/2019.
//

import Foundation
import AdventKit

public class Puzzle {

    let input: [Int]
    public init(input: String) {
        self.input = input.compactMap {
            $0.wholeNumberValue
        }
    }

    public func part1() -> Int {
        let cols = 25
        let rows = 6

        let numberOfLayers = input.count / (cols*rows)
        let layers = (0..<numberOfLayers).reduce(into: [[Int]]()) { arrays, layer in
            let start = (cols*rows) * layer
            arrays.append(Array(input[start..<start + (cols*rows)]))
        }

        let zeroLayer = layers
            .sorted { count(int: 0, in: $0) < count(int: 0, in: $1) }
            .first!

        return count(int: 1, in: zeroLayer) * count(int: 2, in: zeroLayer)
    }

    func count(int: Int, in array: [Int]) -> Int {
        array.filter { $0 == int }.count
    }

    public func part2() -> String {
        let cols = 25
        let rows = 6

        let numberOfLayers = input.count / (cols*rows)
        let layers = (0..<numberOfLayers).reduce(into: [[Int]]()) { arrays, layer in
            let start = (cols*rows) * layer
            arrays.append(Array(input[start..<start + (cols*rows)]))
        }

        var result = Array(repeating: 2, count: cols*rows)
        for layer in layers {
            for pixel in layer.enumerated() {
                if result[pixel.offset] == 2 { result[pixel.offset] = pixel.element }
            }
        }

        return result.enumerated().reduce(into: "") { (string, pixel) in
            if (pixel.offset % cols) == 0 {
                string.append("\n")
            }
            string.append(pixel.element == 1 ? "#" : " ")
        }
    }
}
