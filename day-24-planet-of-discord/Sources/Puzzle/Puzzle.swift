//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 24/12/2019.
//

import Foundation
import AdventKit

public class Puzzle {

    let input: String
    public init(input: String) {
        self.input = input
    }

    public func part1() -> Int {
        var ratings = Set<Int>()
        let eris = Eris(map: input)

        while true {
            eris.step()
            let rating = eris.rating
            if ratings.contains(rating) {
                return rating
            }
            ratings.insert(rating)
        }
    }

    public func part2() -> Int {

        let eris = RecursiveEris(map: input)

        (0..<200).forEach { step in
            eris.step()
        }

        return eris.count
    }
}
