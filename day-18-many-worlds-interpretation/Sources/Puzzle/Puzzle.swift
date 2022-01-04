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
    let source: Point
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

    func astar(grid: [Point: Tile], start: Point, goal: Point, collected: Set<Character>, neighbors: (Point, Set<Character>) -> [Point]) -> Int? {
//        if let cached = cache[Route(source: start, goal: goal)] {
//            return cached
//        }

//        func reconstruct(_ map: [Point: Point], _ point: Point) -> [Point] {
//            var current = point
//            var totalPath = [current]
//            while map.keys.contains(current) {
//                current = map[current]!
//                totalPath.insert(current, at: 0)
//            }
//            return totalPath
//        }

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
                return gScore[current]
            }

            openSet.remove(current)
            for neighbor in neighbors(current, collected) {
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
//        func reconstruct() -> [Point] {
//            S ← empty sequence
//            2  u ← target
//            3  if prev[u] is defined or u = source:          // Do something only if the vertex is reachable
//            4      while u is defined:                       // Construct the shortest path with a stack S
//            5          insert u at the beginning of S        // Push the vertex onto the stack
//            6          u ← prev[u]
//        }

        let neighbors: (Point, Set<Character>) -> [Point] = { point, collected in

            // If we're standing on a key, only proceed if we have that key in
            // our possesion. This way we can minimize visible paths to the
            // 'direct' keys
            if let key = self.keys[point], !collected.contains(key) {
                return []
            }

            return [point.up, point.down, point.left, point.right].filter { p in
                switch self.maze[p] {
                case .open, .key, .entrance:
                    return true
                case .door(let door):
                    return collected.contains(door.lowercased().first!)
                default:
                    return false
                }
            }
        }

        var prev = [GameState: GameState]()
        var dist = [GameState: Int]()
        dist[GameState(point: start, keys: [])] = 0

        var q = PriorityQueue<GameState, Int>()

        // add the direct neighbours to q
        keys.forEach {
            if let route = astar(grid: maze, start: entrance, goal: $0.key, collected: [], neighbors: neighbors) {
                let gameState = GameState(point: $0.key, keys: [$0.value])
                q.insert(gameState, priority: route)
                dist[gameState] = route
            }
        }

        while !q.isEmpty {
            let u = q.removeMin()
            var n = [(GameState, Int)]()
            keys.filter { !u.keys.contains($0.value) }.forEach {
                if let route = astar(grid: maze, start: u.point, goal: $0.key, collected: u.keys, neighbors: neighbors) {
                    n.append((GameState(point: $0.key, keys: u.keys.union([$0.value])), route))
                }
            }

            n.forEach { v in
                let alt = dist[u, default: Int.max] + v.1
                if alt < dist[v.0, default: Int.max] {
                    dist[v.0] = alt
                    prev[v.0] = u
                    q.insert(v.0, priority: alt)
                }
            }
        }

        /*
         dist[source] ← 0                           // Initialization
         3
         4      create vertex priority queue Q
         5
         6      for each vertex v in Graph:
         7          if v ≠ source
         8              dist[v] ← INFINITY                 // Unknown distance from source to v
         9              prev[v] ← UNDEFINED                // Predecessor of v
         10
         11         Q.add_with_priority(v, dist[v])
         12
         13
         14     while Q is not empty:                      // The main loop
         15         u ← Q.extract_min()                    // Remove and return best vertex
         16         for each neighbor v of u:              // only v that are still in Q
         17             alt ← dist[u] + length(u, v)
         18             if alt < dist[v]
         19                 dist[v] ← alt
         20                 prev[v] ← u
         21                 Q.decrease_priority(v, alt)
         22
         23     return dist, prev

         */
//        print(dist)
        let goal = Set<Character>(keys.map { $0.value })
        return dist
            .filter { $0.key.keys == goal }
            .sorted { $0.value < $1.value }
            .first!.value
    }

    public func part1() -> Int {
        draw(grid: maze)
        return dijkstra(grid: maze, start: entrance)
    }

    public func part2() -> Int {
        -1
    }
}
