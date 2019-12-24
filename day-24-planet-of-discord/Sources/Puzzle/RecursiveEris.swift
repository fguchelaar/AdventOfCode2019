//
//  File.swift
//
//
//  Created by Frank Guchelaar on 24/12/2019.
//

import Foundation
import AdventKit

class RecursiveEris {

    private var root = Bugs()

    init(map: String) {
        map
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .enumerated()
            .forEach { line in
                line.element.enumerated().forEach { character in
                    if character.element == "#" {
                        root.add(bug: Point(x: character.offset, y: line.offset))
                    }
                }
        }
    }

    var count: Int {
        root.count + root.countUp + root.countDown
    }

    func step() {
        root.step()
    }
}
