import AdventKit
import Collections
import Foundation

enum Tile {
    case wall
    case open
    case key(letter: String.Element)
    case door(letter: String.Element)
    case entrance
}

extension Point {
    var up: Point { Point(x: x, y: y-1) }
    var down: Point { Point(x: x, y: y + 1) }
    var left: Point { Point(x: x-1, y: y) }
    var right: Point { Point(x: x + 1, y: y) }
}

struct Route {
    let source: GameState
    let goal: Point
}

extension Route: Hashable {}

extension Point: CustomStringConvertible {
    public var description: String {
        "(\(x),\(y))"
    }
}

struct GameState {
    let point: Point
    let keys: Set<Character>
}

extension GameState: Hashable {}
struct GameState2 {
    let points: [Point]
    let keys: Set<Character>
}

extension GameState2: Hashable {}

public class Puzzle {
    var maze: [Point: Tile]
    var keys: [Point: String.Element]
    var doors: [Point: String.Element]
    var entrance: Point

    public init(input: String) {
        maze = [:]
        keys = [:]
        doors = [:]
        entrance = .zero

        input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .enumerated().forEach { y, line in
                line
                    .enumerated().forEach { x, character in
                        let point = Point(x: x, y: y)
                        if character == "#" {
                            maze[point] = .wall
                        }
                        else if character == "." {
                            maze[point] = .open
                        }
                        else if character == "@" {
                            maze[point] = .entrance
                            entrance = point
                        }
                        else if character.isUppercase {
                            maze[point] = .door(letter: character)
                            doors[point] = character
                        }
                        else if character.isLowercase {
                            maze[point] = .key(letter: character)
                            keys[point] = character
                        }
                    }
            }
    }

    var cache = [Route: Int]()
    var unreachable = [Route: Point]()

    func astar(grid: [Point: Tile], start: Point, goal: Point, collected: Set<Character>, neighbors: ([Point: Tile], Point, Set<Character>) -> [Point]) -> Int? {
        let route = Route(source: GameState(point: start, keys: collected), goal: goal)

        if let nope = unreachable[route],
           nope == goal
        {
            return nil
        }

        if let cached = cache[route] {
            return cached
        }

        func h(_ point: Point) -> Int {
            point.manhattan(to: goal)
        }

        var openSet = Set<Point>()
        var cameFrom = [Point: Point]()
        var gScore = [Point: Int]()
        var fScore = [Point: Int]()

        openSet.insert(start)
        gScore[start] = 0
        fScore[goal] = h(start)

        var current: Point
        while !openSet.isEmpty {
            current = openSet.sorted { fScore[$0, default: Int.max] < fScore[$1, default: Int.max] }.first!
            if current == goal {
                cache[route] = gScore[current]
                return gScore[current]
            }

            openSet.remove(current)
            for neighbor in neighbors(grid, current, collected) {
                let tentativeScore = gScore[current, default: Int.max] + 1
                if tentativeScore < gScore[neighbor, default: Int.max] {
                    cameFrom[neighbor] = current
                    gScore[neighbor] = tentativeScore
                    fScore[neighbor] = gScore[neighbor, default: Int.max] + h(neighbor)
                    if !openSet.contains(neighbor) {
                        openSet.insert(neighbor)
                    }
                }
            }
        }
        unreachable[route] = goal
        return nil
    }

    func draw(grid: [Point: Tile]) {
        var output = ""
        let maxPoint = grid.reduce(Point.min) { Point(x: max($0.x, $1.key.x), y: max($0.y, $1.key.y)) }
        for y in 0...maxPoint.y {
            for x in 0...maxPoint.x {
                switch grid[Point(x: x, y: y)] {
                case .wall:
                    output.append("#")
                case .open:
                    output.append(".")
                case .entrance:
                    output.append("@")
                case .door(let door):
                    output.append(door)
                case .key(let key):
                    output.append(key)
                default:
                    output.append(" ")
                }
            }
            output.append("\n")
        }
        print(output)
    }

    func dijkstra(grid: [Point: Tile], start: Point) -> Int {
        let neighbors: ([Point: Tile], Point, Set<Character>) -> [Point] = { grid, point, collected in

            // If we're standing on a key, only proceed if we have that key in
            // our possesion. This way we can minimize visible paths to the
            // 'direct' keys
            if let key = self.keys[point], !collected.contains(key) {
                return []
            }

            return [point.up, point.down, point.left, point.right].filter { p in
                switch grid[p] {
                case .open, .key, .entrance:
                    return true
                case .door(let door):
                    return collected.contains(door.lowercased().first!)
                default:
                    return false
                }
            }
        }

        var dist = [GameState: Int]()
        dist[GameState(point: start, keys: [])] = 0

        var q = PriorityQueue<GameState, Int>()

        // add the direct neighbours to q
        keys.forEach {
            if let route = astar(grid: grid, start: start, goal: $0.key, collected: [], neighbors: neighbors) {
                let gameState = GameState(point: $0.key, keys: [$0.value])
                q.insert(gameState, priority: route)
                dist[gameState] = route
            }
        }

        while !q.isEmpty {
            let u = q.removeMin()
            var n = [(GameState, Int)]()
            keys.filter { !u.keys.contains($0.value) }.forEach {
                if let route = astar(grid: grid, start: u.point, goal: $0.key, collected: u.keys, neighbors: neighbors) {
                    n.append((GameState(point: $0.key, keys: u.keys.union([$0.value])), route))
                }
            }

            n.forEach { v in
                let alt = dist[u, default: Int.max] + v.1
                if alt < dist[v.0, default: Int.max] {
                    dist[v.0] = alt
                    q.insert(v.0, priority: alt)
                }
            }
        }
//        print(dist)
        let goal = Set<Character>(keys.map { $0.value })
        return dist
            .filter { $0.key.keys == goal }
            .sorted { $0.value < $1.value }
            .first!.value
    }

    public func part1() -> Int {
        dijkstra(grid: maze, start: entrance)
    }

    func dijkstra2(grid: [Point: Tile], start: [Point]) -> Int {
        let neighbors: ([Point: Tile], Point, Set<Character>) -> [Point] = { grid, point, collected in

            // If we're standing on a key, only proceed if we have that key in
            // our possesion. This way we can minimize visible paths to the
            // 'direct' keys
            if let key = self.keys[point], !collected.contains(key) {
                return []
            }

            return [point.up, point.down, point.left, point.right].filter { p in
                switch grid[p] {
                case .open, .key, .entrance:
                    return true
                case .door(let door):
                    return collected.contains(door.lowercased().first!)
                default:
                    return false
                }
            }
        }

        var dist = [GameState2: Int]()
        dist[GameState2(points: start, keys: [])] = 0

        var q = PriorityQueue<GameState2, Int>()

        // add the direct neighbours to q
        keys.forEach { k in
            start.enumerated().forEach { s in
                if let route = astar(grid: grid, start: s.element, goal: k.key, collected: [], neighbors: neighbors) {
                    var points = start
                    points[s.offset] = k.key
                    let gameState = GameState2(points: points, keys: [k.value])
                    q.insert(gameState, priority: route)
                    dist[gameState] = route
                }
            }
        }

        while !q.isEmpty {
            let u = q.removeMin()
            var n = [(GameState2, Int)]()
            keys.filter { !u.keys.contains($0.value) }.forEach { k in

                u.points.enumerated().forEach { s in
                    if let route = astar(grid: grid, start: s.element, goal: k.key, collected: u.keys, neighbors: neighbors) {
                        var points = u.points
                        points[s.offset] = k.key
                        n.append((GameState2(points: points, keys: u.keys.union([k.value])), route))
                    }
                }
            }

            n.forEach { v in
                let alt = dist[u, default: Int.max] + v.1
                if alt < dist[v.0, default: Int.max] {
                    dist[v.0] = alt
                    q.insert(v.0, priority: alt)
                }
            }
        }
        let goal = Set<Character>(keys.map { $0.value })
        return dist
            .filter { $0.key.keys == goal }
            .sorted { $0.value < $1.value }
            .first!.value
    }

    public func part2() -> Int {
        cache.removeAll()
        var maze2 = maze
        let r1 = entrance.up.left
        let r2 = entrance.up.right
        let r3 = entrance.down.left
        let r4 = entrance.down.right
        maze2[entrance] = .wall
        maze2[entrance.up] = .wall
        maze2[entrance.left] = .wall
        maze2[entrance.down] = .wall
        maze2[entrance.right] = .wall
        draw(grid: maze2)
        return dijkstra2(grid: maze2, start: [r1, r2, r3, r4])
    }
}
