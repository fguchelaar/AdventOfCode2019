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

class Portal: CustomStringConvertible {

    var name: String
    private (set) var pointA: Point!
    private (set) var pointToA: Point!
    private (set) var pointB: Point!
    private (set) var pointToB: Point!

    var description: String {
        "\(name):\t\(pointA ?? Point.zero)\t <-> \(pointToB ?? Point.zero)\t \t\(pointB ?? Point.zero)\t <-> \(pointToA ?? Point.zero) "
    }

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
        input.trimmingCharacters(in: .newlines)
            .components(separatedBy: .newlines)
            .enumerated().forEach { line in
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

    func drawMap(map: [Point: Tile], start: Point, finish: Point) {
        let minPoint = map.reduce(Point.max) { Point(x: min($0.x, $1.key.x), y: min($0.y, $1.key.y)) }
        let maxPoint = map.reduce(Point.min) { Point(x: max($0.x, $1.key.x), y:  max($0.y, $1.key.y)) }

        var output = ""
        for y in minPoint.y...maxPoint.y {
            for x in minPoint.x...maxPoint.x {
                let point = Point(x: x, y: y)
                if point == start {
                    output += "S"
                } else if point == finish {
                    output += "F"
                } else {
                    switch map[point] {
                    case .free:
                        output += "."
                    case .wall:
                        output += "#"
                    case .portal:
                        output += "@"
                    default:
                        output += " "
                    }
                }
            }
            output += "\n"
        }
        print(output)
    }

    public func part1() -> Int {
        drawMap(map: map, start: start, finish: finish)

        let distance = dijkstra(graph: map, source: start, target: finish) { point in
            [point.up, point.down, point.left, point.right]
                .compactMap { nb in
                    switch map[nb] {
                    case .free:
                        return nb
                    case .portal(let portal):
                        return portal.teleport(from: nb)
                    default:
                        return nil
                    }
            }
        }

        return distance
    }

    func dijkstra(graph: [Point: Tile], source: Point, target: Point, neighbors: (_ of: Point) -> [Point]) -> Int {
        var q = Set<Point>(graph.filter {
            switch $0.value {
            case .free: return true
            default: return false
            }
        }.map { $0.key })

        var dist = [source: 0]

        while !q.isEmpty {
            let u = dist
                .filter { q.contains($0.key) }
                .sorted { $0.value < $1.value }
                .first!.key

            if u == target {
                break
            }
            q.remove(u)

            // There are some unreachable points in the input, they'll alwasy
            // have Int.max as distance. So let's skip those
            if dist[u, default: Int.max] != Int.max {
                for v in neighbors(u) {
                    let alt = dist[u]! + 1
                    if alt < dist[v, default: Int.max] {
                        dist[v] = alt
                    }
                }
            }
        }

        return dist[target]!
    }

    public func part2() -> Int {
        -1
    }
}
