//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 30/11/2019.
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

    public func part2() -> String {
        ""
    }
}
