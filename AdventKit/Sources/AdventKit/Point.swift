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

    public static var zero: Point {
        Point(x: 0, y: 0)
    }

    public static var min: Point {
        Point(x: Int.min, y: Int.min)
    }

    public static var max: Point {
        Point(x: Int.max, y: Int.max)
    }

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

    /// calculates the angle in radians between two points; normalized where `0.0` is **up**
    public func angle(to other: Point) -> Double {
        let dy = other.y - y
        let dx = other.x - x
        let rad = atan2(Double(dy), Double(dx))
        return (rad + (0.5 * .pi) + (2 * .pi)).truncatingRemainder(dividingBy: 2 * .pi)
    }
}
