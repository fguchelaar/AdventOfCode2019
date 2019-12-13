//
//  Point3d.swift
//  
//
//  Created by Frank Guchelaar on 12/12/2019.
//

import Foundation

public struct Point3d: Equatable, Hashable {
    public let x: Int
    public let y: Int
    public let z: Int

    public static var zero: Point3d {
        Point3d(x: 0, y: 0, z: 0)
    }

    public init(x: Int, y: Int, z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }

    /// returns the manhattan distance between this Point3d and the provided one
    public func manhattan(to other: Point3d) -> Int {
        return abs(other.x - x) + abs(other.y - y) + abs(other.z - z)
    }

    /// adds two points and returns the result
    public static func +(lhs: Point3d, rhs: Point3d) -> Point3d {
        Point3d(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
}
