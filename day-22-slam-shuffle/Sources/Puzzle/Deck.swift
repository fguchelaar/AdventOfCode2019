//
//  File.swift
//  
//
//  Created by Frank Guchelaar on 23/12/2019.
//

import Foundation

class Deck {

    /// Wrapper around an array, so it can be used with reference type semantics
    private class Cards {
        var array: [Int]
        init(array: [Int]) {
            self.array = array
        }

        func get(at: Int) -> Int {
            array[at]
        }

        func set(int: Int, at: Int) {
            array[at] = int
        }
    }

    var count: Int
    private var cardsA: Cards
    private var cardsB: Cards
    var toggled = false

    private var activeCards: Cards {
        toggled ? cardsB : cardsA
    }

    private var tempCards: Cards {
        toggled ? cardsA : cardsB
    }

    var cards: [Int] {
        activeCards.array
    }

    init(count: Int) {
        self.count = count
        let array = Array<Int>(repeating: 0, count: count)
        cardsA = Cards(array: array)
        cardsB = Cards(array: array)
        for i in 0..<count {
            activeCards.set(int: i, at: i)
        }
    }

    func deal(with increment: Int) {
        var j = 0
        for i in 0..<count {
            tempCards.set(int: activeCards.get(at: i), at: j)
            j = (j + increment) % count
        }
        toggled.toggle()
    }

    func cut(count cutCount: Int) {
        for i in 0..<count {
            let j = (i + cutCount + count) % count
            tempCards.set(int: activeCards.get(at: j), at: i)
        }
        toggled.toggle()
    }

    func dealIntoNew() {
        for i in 0..<count {
            let j = count - i - 1
            tempCards.set(int: activeCards.get(at: j), at: i)
        }
        toggled.toggle()
    }

    func position(of card: Int) -> Int {
        activeCards.array.firstIndex(of: card)!
    }
}
