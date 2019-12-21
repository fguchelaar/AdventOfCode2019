//
//  Node.swift
//  
//
//  Created by Frank Guchelaar on 21/12/2019.
//

import Foundation

public class Node<T> {
    var value: T
    var next: Node<T>?
    weak var previous: Node<T>?

    init(value: T) {
        self.value = value
    }
}
