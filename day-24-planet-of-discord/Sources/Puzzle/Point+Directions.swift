//
//  File.swift
//  
//
//  Created by Frank Guchelaar on 24/12/2019.
//

import Foundation
import AdventKit

extension Point {
    var up: Point { Point(x: x, y: self.y-1) }
    var down: Point { Point(x: x, y: self.y+1) }
    var left: Point { Point(x: x-1, y: self.y) }
    var right: Point { Point(x: x+1, y: self.y) }
}
