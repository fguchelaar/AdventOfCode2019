//
//  Moon.swift
//  
//
//  Created by Frank Guchelaar on 12/12/2019.
//

import Foundation
import AdventKit

public class Moon: Equatable, Hashable, CustomStringConvertible {
    public static func == (lhs: Moon, rhs: Moon) -> Bool {
        lhs.position == rhs.position && lhs.velocity == rhs.velocity
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(position)
        hasher.combine(velocity)
    }

    var position: Point3d
    var velocity: Point3d

    var startPosition: Point3d
    var startVelocity: Point3d

    var potential: Int {
        abs(position.x) + abs(position.y) + abs(position.z)
    }

    var kinetic: Int {
        abs(velocity.x) + abs(velocity.y) + abs(velocity.z)
    }

    var total: Int {
        potential * kinetic
    }

    var isAtStartX: Bool {
        position.x == startPosition.x && velocity.x == startVelocity.x
    }

    var isAtStartY: Bool {
        position.y == startPosition.y && velocity.y == startVelocity.y
    }
    
    var isAtStartZ: Bool {
        position.z == startPosition.z && velocity.z == startVelocity.z
    }

    init(x: Int, y: Int, z: Int) {
        position = Point3d(x: x, y: y, z: z)
        startPosition = position

        velocity = .zero
        startVelocity = .zero
    }

    func applyGravity(from moons: [Moon]) {
        moons.forEach { moon in
            let x = moon.position.x < position.x ? -1 : moon.position.x > position.x ? 1 : 0
            let y = moon.position.y < position.y ? -1 : moon.position.y > position.y ? 1 : 0
            let z = moon.position.z < position.z ? -1 : moon.position.z > position.z ? 1 : 0
            velocity = velocity + Point3d(x: x, y: y, z: z)
        }
    }

    func move() {
        position = position + velocity
    }

    public var description: String {
        "pos=<x=\(position.x), y=\(position.y), z=\(position.z)>, vel=<x=\(velocity.x), y=\(velocity.y), z=\(velocity.z)>"
    }
}
