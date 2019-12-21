//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 30/11/2019.
//

import Foundation
import AdventKit

extension Point {
    var up: Point { Point(x: x, y: y-1)}
    var down: Point { Point(x: x, y: y+1)}
    var left: Point { Point(x: x-1, y: y)}
    var right: Point { Point(x: x+1, y: y)}
}

enum Tile {
    case wall
    case free
    case portal(_: Portal)
}

class Portal {

    var name: String
    private (set) var pointA: Point!
    private (set) var pointToA: Point!
    private (set) var pointB: Point!
    private (set) var pointToB: Point!

    init(name: String) {
        self.name = name
    }

    func add(point: Point, to: Point) {
        if pointA == nil {
            pointA = point
            pointToA = to
        } else if pointB == nil {
            pointB = point
            pointToB = to
        } else {
            fatalError("there can be no more than two points")
        }
    }

    func teleport(from: Point) -> Point {
        guard from == pointA || from == pointB else {
            fatalError("Point \(from) is not part of this portal")
        }

        if from == pointA {
            return pointToB
        }
        return pointToA
    }
}

public class Puzzle {

    let map: [Point: Tile]
    let start: Point
    let finish: Point

    public init(input: String) {
        let parsed = Puzzle.parse(input)
        map = parsed.0
        start = parsed.1
        finish = parsed.2
    }

    static func parse(_ input: String) -> ([Point: Tile], Point, Point) {
        var characters = input
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: .newlines)
            .map { $0.map { String($0) } }

        var portals = [String: Portal]()

        func parsePortal(at: Point) -> Portal? {
            guard at.x != 0
                && at.y != 0
                && at.x < characters[at.y].count - 1
                && at.y < characters.count - 1 else {
                    return nil
            }

            var name = String(characters[at.y][at.x])
            var tile = Point.zero
            if characters[at.up.y][at.x] == "." {
                tile = Point(x: at.x, y: at.up.y)
                name = "\(name)\(characters[at.down.y][at.x])"
            } else if characters[at.down.y][at.x] == "." {
                tile = Point(x: at.x, y: at.down.y)
                name = "\(characters[at.up.y][at.x])\(name)"
            } else if characters[at.y][at.left.x] == "." {
                tile = Point(x: at.left.x, y: at.y)
                name = "\(name)\(characters[at.y][at.right.x])"
            } else if characters[at.y][at.right.x] == "." {
                tile = Point(x: at.right.x, y: at.y)
                name = "\(characters[at.y][at.left.x])\(name)"
            } else {
                return nil
            }

            let portal = portals[name, default: Portal(name: name)]
            portals[name] = portal
            portal.add(point: at, to: tile)

            if name != "AA" && name != "ZZ" {
                return portal
            } else {
                return nil
            }
        }

        var map = [Point: Tile]()
        characters.enumerated().forEach { line in
            line.element.enumerated().forEach { character in
                let point = Point(x: character.offset, y: line.offset)
                if character.element == "#" {
                    map[point] = .wall
                } else if character.element == "." {
                    map[point] = .free
                } else if character.element != " " {
                    if let portal = parsePortal(at: point) {
                        map[point] = .portal(portal)
                    }
                }
            }
        }
        return (map, portals["AA"]!.pointToA, portals["ZZ"]!.pointToA)
    }

    public func part1() -> Int {

        let neighborFunction: (Point) -> [Point] = { point in
            [point.up, point.down, point.left, point.right]
                .compactMap { nb in
                    switch self.map[nb] {
                    case .free:
                        return nb
                    case .portal(let portal):
                        return portal.teleport(from: nb)
                    default:
                        return nil
                    }
            }
        }

        return bfs(graph: map,
                   source: start,
                   target: finish,
                   neighbors: neighborFunction)
    }

    func bfs(graph: [Point: Tile], source: Point, target: Point, neighbors: (_ of: Point) -> [Point]) -> Int {

        // keep reference to the distance
        var dist = [source: 0]
        var queue = Queue<Point>()
        var discovered = Set<Point>()
        discovered.insert(source)

        queue.enqueue(source)

        while !queue.isEmpty {
            let v = queue.dequeue()!
            if v == target {
                break
            }

            for w in neighbors(v) {
                if !discovered.contains(w) {
                    discovered.insert(w)
                    dist[w] = dist[v]! + 1
                    queue.enqueue(w)
                }
            }
        }
        return dist[target]!
    }

    public func part2() -> Int {
        let maxPoint = map.reduce(Point.min) { Point(x: max($0.x, $1.key.x), y:  max($0.y, $1.key.y)) }

        let neighborFunction: (Point3d) -> [Point3d] = { point3d in
            let point = Point(x: point3d.x, y: point3d.y)
            return [point.up, point.down, point.left, point.right]
                .compactMap { nb in
                    switch self.map[nb] {
                    case .free:
                        return Point3d(x: nb.x, y: nb.y, z: point3d.z)
                    case .portal(let portal):
                        let to = portal.teleport(from: nb)

                        let isOutside = nb.x == 1 || nb.y == 1
                            || nb.x == maxPoint.x
                            || nb.y == maxPoint.y

                        if isOutside && point3d.z == 0 {
                            return nil
                        } else {
                            let dz = isOutside ? -1 : 1
                            return Point3d(x: to.x, y: to.y, z: point3d.z + dz)
                        }
                    default:
                        return nil
                    }
            }
        }

        return bfs3d(graph: map,
                     source: start,
                     target: finish,
                     neighbors: neighborFunction)

    }

    func bfs3d(graph: [Point: Tile], source: Point, target: Point, neighbors: (_ of: Point3d) -> [Point3d]) -> Int {

        let source3d = Point3d(x: source.x, y: source.y, z: 0)
        let target3d = Point3d(x: target.x, y: target.y, z: 0)

        // keep reference to the distance
        var dist = [source3d: 0]
        var queue = Queue<Point3d>()
        var discovered = Set<Point3d>()
        discovered.insert(source3d)

        queue.enqueue(source3d)

        while !queue.isEmpty {
            let v = queue.dequeue()!
            if v == target3d {
                break
            }

            for w in neighbors(v) {
                if !discovered.contains(w) {
                    discovered.insert(w)
                    dist[w] = dist[v]! + 1
                    queue.enqueue(w)
                }
            }
        }
        return dist[target3d]!
    }
}
