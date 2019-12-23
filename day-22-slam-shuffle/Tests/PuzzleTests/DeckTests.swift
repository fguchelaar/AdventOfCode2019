import XCTest
@testable import Puzzle

final class DeckTests: XCTestCase {
    
    func testDealIntoNew()  {
        let deck = Deck(count: 10)
        deck.dealIntoNew()
        XCTAssertEqual(deck.cards, [9,8,7,6,5,4,3,2,1,0])
        deck.dealIntoNew()
        XCTAssertEqual(deck.cards, [0,1,2,3,4,5,6,7,8,9])
    }

    func testCut()  {
        var deck = Deck(count: 10)
        deck.cut(count: 3)
        XCTAssertEqual(deck.cards, [3,4,5,6,7,8,9,0,1,2])
        deck.cut(count: 1)
        XCTAssertEqual(deck.cards, [4,5,6,7,8,9,0,1,2,3])

        deck = Deck(count: 10)
        deck.cut(count: -4)
        XCTAssertEqual(deck.cards, [6,7,8,9,0,1,2,3,4,5])
    }

    func testDealWithIncrement()  {
        let deck = Deck(count: 10)
        deck.deal(with: 3)
        XCTAssertEqual(deck.cards, [0,7,4,1,8,5,2,9,6,3])
    }

    func testPostionOfCard()  {
        let deck = Deck(count: 10)
        deck.deal(with: 3)
        XCTAssertEqual(deck.cards, [0,7,4,1,8,5,2,9,6,3])
        XCTAssertEqual(deck.position(of: 0), 0)
        XCTAssertEqual(deck.position(of: 7), 1)
        XCTAssertEqual(deck.position(of: 9), 7)
    }

    static var allTests = [
        ("testDealIntoNew", testDealIntoNew),
        ("testCut", testCut),
        ("testDealWithIncrement", testDealWithIncrement),
        ("testPostionOfCard", testPostionOfCard),
    ]
}
