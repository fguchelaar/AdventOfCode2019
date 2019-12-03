//
//  Point.swift
//  
//
//  Created by Frank Guchelaar on 03/12/2019.
//

import Foundation

public struct Point: Equatable, Hashable {
    public let x: Int
    public let y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    /// returns the manhattan distance between this Point and the provided one
    public func manhattan(to other: Point) -> Int {
        return abs(other.x - x) + abs(other.y - y)
    }

    /// adds two points and returns the result
    public static func +(lhs: Point, rhs: Point) -> Point {
        Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}
