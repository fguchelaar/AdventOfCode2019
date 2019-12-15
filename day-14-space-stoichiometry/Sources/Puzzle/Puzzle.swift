//
//  Puzzle.swift
//  
//
//  Created by Frank Guchelaar on 30/11/2019.
//

import Foundation
import AdventKit

struct Reaction {
    var inputs: [String: Int]
    var output: String
    var amount: Int
}

class NanoFactory {

    let reactions: [Reaction]
    init(reactions: [Reaction]) {
        self.reactions = reactions
    }

    var requested = [String: Int]()
    var generated = [String: Int]()

    func requestFuel(amount: Int) {
        requested["FUEL"] = amount

        while !requested.allSatisfy { $0.key == "ORE" } {

            let request = requested.first { $0.key != "ORE" }!
            let leftOver = generated[request.key, default: 0] - request.value

            if leftOver >= 0 {
                generated[request.key] = leftOver
                requested.removeValue(forKey: request.key)
            } else {
                generated[request.key] = 0

                let reaction = reactions.first { $0.output == request.key }!
                for input in reaction.inputs {

                    let leftOver2 = generated[input.key, default: 0] - input.value
                    if leftOver2 >= 0 {
                        generated[input.key] = leftOver2
                    } else {
                        generated[input.key] = 0
                        requested[input.key, default: 0] += abs(leftOver2)
                    }
                }



                generated[request.key, default: 0] += leftOver + reaction.amount

                if generated[request.key, default: 0] < 0 {
                    requested[request.key, default: 0] = abs(leftOver) - reaction.amount
                    generated[request.key] = 0
                } else {

                    requested[request.key, default: 0] -= reaction.amount
                    if requested[request.key, default: 0] <= 0 {
                        requested.removeValue(forKey: request.key)
                    }
                }
            }
        }

    }

}

public class Puzzle {

    let reactions: [Reaction]
    public init(input: String) {
        self.reactions =
            input.array(separatedBy: .newlines, using: Puzzle.parse(reaction:))
    }

    class func parse(reaction: String) -> Reaction {
        let parts = reaction
            .components(separatedBy: CharacterSet(charactersIn: ", =>"))
            .filter { !$0.isEmpty }

        let inputs = stride(from: 0, to: parts.count-2, by: 2)
            .reduce(into: [String: Int]()) {
                $0[parts[$1+1]] = Int(parts[$1])!
        }

        let output = parts.last!
        let amount = Int(parts.suffix(2).first!)!

        return Reaction(inputs: inputs, output: output, amount: amount)
    }



    public func part1() -> Int {
        let factory = NanoFactory(reactions: reactions)
        factory.requestFuel(amount: 1)
        return factory.requested["ORE"]!
    }

    public func part2() -> Int {
        let factory = NanoFactory(reactions: reactions)
        var fuelCount = 0
        while factory.requested["ORE", default: 0] < 1_000_000_000_000 {
            factory.requestFuel(amount: 1000)
            fuelCount += 1000
            let ore = factory.requested["ORE"]!
            let ratio = Double(ore) / Double(fuelCount)
            print("after \(fuelCount): \(ore). Ratio: \(ratio)")
        }
        return fuelCount
    }
}
