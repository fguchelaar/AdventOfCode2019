//
//  Queue.swift
//  
//
//  Created by Frank Guchelaar on 21/12/2019.
//

import Foundation

public struct Queue<T> {

    private var list: LinkedList<T>

    public var isEmpty: Bool { list.isEmpty }

    public var count: Int {
        list.count
    }

    public init() {
        list = LinkedList<T>()
    }

    public mutating func enqueue(_ value: T) {
        list.append(value)
    }

    public mutating func dequeue() -> T? {
        guard let node = list.first else {
            return nil
        }
        return list.remove(node: node)
    }

    public mutating func removeAll() {
        list.removeAll()
    }
}
