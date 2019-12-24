//
//  LinkedList.swift
//  
//
//  Created by Frank Guchelaar on 21/12/2019.
//

import Foundation

public class LinkedList<T> {

    private var head: Node<T>?
    private var tail: Node<T>?

    var isEmpty: Bool {
        head == nil
    }

    var first: Node<T>? {
        head
    }

    var last: Node<T>? {
        tail
    }

    var count: Int {
        guard var node = head else {
            return 0
        }

        var count = 0

        while node !== tail {
            node = node.next!
            count += 1
        }

        return count + 1
    }

    func append(_ value: T) {
        let newNode = Node(value: value)
        if let tailNode = tail {
            newNode.previous = tailNode
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }

    func remove(node: Node<T>) -> T {
        let prev = node.previous
        let next = node.next

        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev

        if next == nil {
            tail = prev
        }

        node.previous = nil
        node.next = nil

        return node.value
    }

    func removeAll() {
        head = nil
        tail = nil
    }
}
